package graceful

import "sync"

type GracefulFunc[T any] func() (t T, cleanup func())

type Graceful interface {
	Add(func())
	Shutdown()
}

func AddFunc[T any](graceful Graceful, gracefulFunc GracefulFunc[T]) T {
	t, c := gracefulFunc()
	graceful.Add(c)
	return t
}

type impl struct {
	cleanupfuncs []func()
}

func New() Graceful {
	return &impl{}
}

func (g *impl) Add(cleanupfunc func()) {
	g.cleanupfuncs = append(g.cleanupfuncs, cleanupfunc)
}

func (g *impl) Shutdown() {
	wg := &sync.WaitGroup{}
	for _, f := range g.cleanupfuncs {
		wg.Add(1)
		go func(f func()) {
			f()
			defer wg.Done()
		}(f)
	}
	wg.Wait()
}

func NoOp() {

}

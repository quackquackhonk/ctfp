


pub fn id<A>(x: A) -> A{
    return x;
}

pub fn compose<Ft: 'static, Gt: 'static, A, B, C>(f: Ft, g: Gt) -> Box<dyn Fn(A) -> C>
where
    Ft: Fn(B) -> C,
    Gt: Fn(A) -> B,
{
    return Box::new(move | x | f(g(x)))
}

#[cfg(test)]
mod tests {

    use crate::id;
    use crate::compose;

    #[test]
    fn it_works() {
        let result = 2 + 2;
        assert_eq!(result, 4);
    }

    #[test]
    fn id_test() {
        assert_eq!(id(10), 10);
        assert_eq!(id(true), true);
        assert_eq!(id(10), 10);

    }

    fn add1(xx: i32) -> i32 {
        return xx + 1;
    }

    fn triple(xx: i32) -> i32 {
        return xx * 3;
    }

    #[test]
    fn compose_test() {
        assert_eq!(compose(add1, id)(1), 2);
        assert_eq!(compose(id, add1)(1), 2);
        assert_eq!(compose(triple, add1)(1),6);
    }
}

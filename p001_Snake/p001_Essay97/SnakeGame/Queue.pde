public class Queue<T>{
  private ArrayList<T> queue = new ArrayList<T>();
  
  private Queue(){}
  
  public boolean empty(){
    return queue.size() == 0;
  }
  
  public void enqueue(T item){
    queue.add(item);
  }
    
  public T dequeue(){
    return queue.get(0);
  }
  
  public ArrayList<T> getList(){
    return queue;
  }
}

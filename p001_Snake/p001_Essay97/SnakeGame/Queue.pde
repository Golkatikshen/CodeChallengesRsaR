public class Queue<T>{
  private ArrayList<T> queue = new ArrayList<T>();
  private int  size;
  
  public Queue(){
    this.size = 0;
  }
  
  public boolean empty(){
    return size == 0;
  }
  
  public void enqueue(T item){
    queue.add(item);
    size++;
  }
    
  public T dequeue(){
    size--;
    return queue.get(0);
  }
  
  public ArrayList<T> getList(){
    return queue;
  }
  
  public int getSize(){
    return size;
  }
}

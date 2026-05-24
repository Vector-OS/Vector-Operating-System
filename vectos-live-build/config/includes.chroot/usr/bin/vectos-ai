#!/usr/bin/env python3
"""
VectOS AI Assistant - simple Tkinter stub
Replace the fake response with a real AI backend (OpenAI or local LLM).
"""
import tkinter as tk
from tkinter import simpledialog
import threading

def send():
    msg = entry.get()
    if not msg.strip():
        return
    chat.insert(tk.END, "You: " + msg + "\n")
    entry.delete(0, tk.END)

    # fake async response
    def fake_response():
        chat.insert(tk.END, "VectOS AI: Thinking...\n")
        chat.see(tk.END)
        import time
        time.sleep(1.2)
        chat.insert(tk.END, "VectOS AI: (This is a stub response. Connect to an AI backend.)\n")
        chat.see(tk.END)

    threading.Thread(target=fake_response, daemon=True).start()

root = tk.Tk()
root.title("VectOS AI Assistant")
root.geometry("420x480")
root.configure(bg="#0b0f1a")

chat = tk.Text(root, bg="#0f1720", fg="#00ffe1", wrap='word')
chat.pack(expand=True, fill="both")

frame = tk.Frame(root)
frame.pack(fill='x')
entry = tk.Entry(frame)
entry.pack(side='left', expand=True, fill='x')
btn = tk.Button(frame, text="Send", command=send)
btn.pack(side='right')

root.mainloop()

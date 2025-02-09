import streamlit as st
import streamlit.components.v1 as components

def my_component(name="World"):
    with open("embed_stuff.js", "r") as f:
        k = f.read()
    return k

def main():
    st.set_page_config(page_title="Home", layout="wide")
    st.title("Matematica SC")
    st.write("Homepage for our mathematica smart contract.")

    

    st.header("Hackbot embedding")
    st.code(my_component(), language="javascript")
    #st.components.v1.html(my_component())


if __name__ == "__main__":
    main()
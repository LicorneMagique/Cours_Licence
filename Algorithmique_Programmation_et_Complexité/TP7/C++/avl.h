/**
 * Réalisé par Julien GIRAUD - 2019
 */

#ifndef _AVL
#define _AVL

#include "element.h"

class Node
{
    friend class AVL;
    public:
        Node(Elem);
        Node(const Node*);
        bool operator<(const Node&);
        int getHeight();
        int getDifference();
        void add(Elem);
        void equilibre();
        void vide();

        // Rotations
        void rotationDroite();
        void rotationGauche();
        void rotationDoubleDroite();
        void rotationDoubleGauche();

        // Affichage
        void show(int);
        void show_infix();
        void show_prefix();
        void show_postfix();
        
    private :
        Elem elem;
        int hauteur;
        Node* fg;
        Node* fd;
};

class AVL
{
    public :
        // Constructeurs ---- Destructeur
        AVL(); // Constructeur par défaut
        AVL(const AVL&); // Constructeur par copie
        ~AVL();

        // Fonctions de manipulation de l'arbre
        bool search(Elem);
        int getHeight();
        void add(Elem);
        void vide();

        // Affichage
        void show();
        void show_infix();
        void show_prefix();
        void show_postfix();
        
        // Surcharge d'opérateur
        AVL& operator=(const AVL &);

    private :
        Node * racine;
};

#endif

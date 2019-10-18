package com.sedoc.sedocuments.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * 丁佳男
 */
public class TreeNodeBuilder {

    /**
     * 把简单的集合转换成有层级关系的集合
     */
    public static List<TreeNode> build(List<TreeNode> nodes,Integer topPid){
        List<TreeNode> treeNodes = new ArrayList<>();
        for (TreeNode n1 : nodes){
            if(n1.getPid()==topPid){
                treeNodes.add(n1);
            }
            for (TreeNode n2:nodes){
                if (n2.getPid()==n1.getId()){
                    n1.getChildren().add(n2);
                }
            }
        }
        return treeNodes;
    }
}

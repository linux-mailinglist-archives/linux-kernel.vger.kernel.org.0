Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8646C184587
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgCMLEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 07:04:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbgCMLEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:04:55 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DB35ml076016
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:04:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yqyhtamg5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:04:52 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 13 Mar 2020 11:04:49 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Mar 2020 11:04:45 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02DB4ivV40239484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 11:04:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02E884204F;
        Fri, 13 Mar 2020 11:04:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8041D4204D;
        Fri, 13 Mar 2020 11:04:41 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 13 Mar 2020 11:04:41 +0000 (GMT)
Date:   Fri, 13 Mar 2020 16:34:40 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christopher Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 1/3] powerpc/numa: Set numa_node for all possible cpus
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200311110237.5731-2-srikar@linux.vnet.ibm.com>
 <20200311115735.GM23944@dhcp22.suse.cz>
 <20200312052707.GA3277@linux.vnet.ibm.com>
 <C5560C71-483A-41FB-BDE9-526F1E0CFA36@linux.vnet.ibm.com>
 <5e5c736a-a88c-7c76-fc3d-7bc765e8dcba@suse.cz>
 <20200312131438.GB3277@linux.vnet.ibm.com>
 <61437352-8b54-38fa-4471-044a65c9d05a@suse.cz>
 <20200312161310.GC3277@linux.vnet.ibm.com>
 <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
 <CAAmzW4OFy51BhAT62tdVQD52NNMWm+UPgoGAX97omY7P+nJ+5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAAmzW4OFy51BhAT62tdVQD52NNMWm+UPgoGAX97omY7P+nJ+5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 20031311-0012-0000-0000-0000039069FE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031311-0013-0000-0000-000021CD3F2C
Message-Id: <20200313110440.GA25144@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_04:2020-03-12,2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Joonsoo Kim <js1304@gmail.com> [2020-03-13 18:47:49]:

> > >>
> > >> > Also for a memoryless/cpuless node or possible but not present nodes,
> > >> > node_to_mem_node(node) will still end up as node (atleast on powerpc).
> > >>
> > >> I think that's the place where this would be best to fix.
> > >>
> > >
> > > Maybe. I thought about it but the current set_numa_mem semantics are apt
> > > for memoryless cpu node and not for possible nodes.  We could have upto 256
> > > possible nodes and only 2 nodes (1,2) with cpu and 1 node (1) with memory.
> > > node_to_mem_node seems to return what is set in set_numa_mem().
> > > set_numa_mem() seems to say set my numa_mem node for the current memoryless
> > > node to the param passed.
> > >
> > > But how do we set numa_mem for all the other 253 possible nodes, which
> > > probably will have 0 as default?
> > >
> > > Should we introduce another API such that we could update for all possible
> > > nodes?
> >
> > If we want to rely on node_to_mem_node() to give us something safe for each
> > possible node, then probably it would have to be like that, yeah.
> >
> > >> > I tried with this hunk below and it works.
> > >> >
> > >> > But I am not sure if we need to check at other places were
> > >> > node_present_pages is being called.
> > >>
> > >> I think this seems to defeat the purpose of node_to_mem_node()? Shouldn't it
> > >> return only nodes that are online with present memory?
> > >> CCing Joonsoo who seems to have introduced this in ad2c8144418c ("topology: add
> > >> support for node_to_mem_node() to determine the fallback node")
> > >>
> > >
> > > Agree
> 
> I lost all the memory about it. :)
> Anyway, how about this?
> 
> 1. make node_present_pages() safer
> static inline node_present_pages(nid)
> {
> if (!node_online(nid)) return 0;
> return (NODE_DATA(nid)->node_present_pages);
> }
> 

Yes this would help.

> 2. make node_to_mem_node() safer for all cases
> In ppc arch's mem_topology_setup(void)
> for_each_present_cpu(cpu) {
>  numa_setup_cpu(cpu);
>  mem_node = node_to_mem_node(numa_mem_id());
>  if (!node_present_pages(mem_node)) {
>   _node_numa_mem_[numa_mem_id()] = first_online_node;
>  }
> }
> 

But here as discussed above, we miss the case of possible but not present nodes.
For such nodes, the above change may not update, resulting in they still
having 0. And node 0 can be only possible but not present.

-- 
Thanks and Regards
Srikar Dronamraju


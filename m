Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 882D7ABC30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394731AbfIFPWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 11:22:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbfIFPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:22:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x86FCIuA027193;
        Fri, 6 Sep 2019 11:21:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uuqcdqaar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Sep 2019 11:21:38 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x86FCXgB030046;
        Fri, 6 Sep 2019 11:21:37 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uuqcdqa9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Sep 2019 11:21:37 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x86FA9xa031922;
        Fri, 6 Sep 2019 15:21:36 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 2uqgh7wv7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Sep 2019 15:21:36 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x86FLZqn35455330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Sep 2019 15:21:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C8FAB2067;
        Fri,  6 Sep 2019 15:21:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E713B2064;
        Fri,  6 Sep 2019 15:21:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  6 Sep 2019 15:21:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6D8A216C2C84; Fri,  6 Sep 2019 08:21:44 -0700 (PDT)
Date:   Fri, 6 Sep 2019 08:21:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH -rcu dev 1/2] Revert b8c17e6664c4 ("rcu: Maintain special
 bits at bottom of ->dynticks counter")
Message-ID: <20190906152144.GF4051@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190830162348.192303-1-joel@joelfernandes.org>
 <20190903200249.GD4125@linux.ibm.com>
 <20190904045910.GC144846@google.com>
 <20190904101210.GM4125@linux.ibm.com>
 <20190904135420.GB240514@google.com>
 <20190904231308.GB4125@linux.ibm.com>
 <20190905153620.GG26466@google.com>
 <20190905164329.GT4125@linux.ibm.com>
 <20190906000137.GA224720@google.com>
 <20190906150806.GA11355@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906150806.GA11355@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909060161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:08:06AM -0400, Joel Fernandes wrote:
> On Thu, Sep 05, 2019 at 08:01:37PM -0400, Joel Fernandes wrote:
> [snip] 
> > > > > @@ -3004,7 +3007,7 @@ static int rcu_pending(void)
> > > > >  		return 0;
> > > > >  
> > > > >  	/* Is the RCU core waiting for a quiescent state from this CPU? */
> > > > > -	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm)
> > > > > +	if (READ_ONCE(rdp->core_needs_qs) && !rdp->cpu_no_qs.b.norm)
> > > > >  		return 1;
> > > > >  
> > > > >  	/* Does this CPU have callbacks ready to invoke? */
> > > > > @@ -3244,7 +3247,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
> > > > >  	rdp->gp_seq = rnp->gp_seq;
> > > > >  	rdp->gp_seq_needed = rnp->gp_seq;
> > > > >  	rdp->cpu_no_qs.b.norm = true;
> > > > > -	rdp->core_needs_qs = false;
> > > > 
> > > > How about calling the new hint-clearing function here as well? Just for
> > > > robustness and consistency purposes?
> > > 
> > > This and the next function are both called during a CPU-hotplug online
> > > operation, so there is little robustness or consistency to be had by
> > > doing it twice.
> > 
> > Ok, sorry I missed you are clearing it below in the next function. That's
> > fine with me.
> > 
> > This patch looks good to me and I am Ok with merging of these changes into
> > the original patch with my authorship as you mentioned. Or if you wanted to
> > be author, that's fine too :)
> 
> Paul, does it make sense to clear these urgency hints in rcu_qs() as well?
> After all, we are clearing atleast one urgency hint there: the
> rcu_read_unlock_special::need_qs bit.

We certainly don't want to turn off the scheduling-clock interrupt until
after the quiescent state has been reported to the RCU core.  And it might
still be useful to have a heavy quiescent state because the grace-period
kthread can detect that.  Just in case the CPU that just called rcu_qs()
is slow about actually reporting that quiescent state to the RCU core.

							Thanx, Paul

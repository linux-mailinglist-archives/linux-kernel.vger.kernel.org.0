Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0C10DFB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 22:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfEAU1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 16:27:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbfEAU1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:27:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41KMsc9036783
        for <linux-kernel@vger.kernel.org>; Wed, 1 May 2019 16:27:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7gh8n603-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 16:27:17 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 1 May 2019 21:27:16 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 21:27:14 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41KRDMx27656232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 20:27:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6A0BB205F;
        Wed,  1 May 2019 20:27:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAEF0B2065;
        Wed,  1 May 2019 20:27:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 May 2019 20:27:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D6EE516C19D9; Wed,  1 May 2019 13:27:13 -0700 (PDT)
Date:   Wed, 1 May 2019 13:27:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com
Subject: Re: Question about sched_setaffinity()
Reply-To: paulmck@linux.ibm.com
References: <20190427180246.GA15502@linux.ibm.com>
 <20190430100318.GP2623@hirez.programming.kicks-ass.net>
 <20190430105129.GA3923@linux.ibm.com>
 <20190430115551.GT2623@hirez.programming.kicks-ass.net>
 <20190501191213.GX3923@linux.ibm.com>
 <20190501151655.51469a4c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501151655.51469a4c@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19050120-0040-0000-0000-000004E9BA8C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011030; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197178; UDB=6.00627891; IPR=6.00978032;
 MB=3.00026686; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-01 20:27:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050120-0041-0000-0000-000008F5BED2
Message-Id: <20190501202713.GY3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 03:16:55PM -0400, Steven Rostedt wrote:
> On Wed, 1 May 2019 12:12:13 -0700
> "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> 
> 
> > OK, what I did was to apply the patch at the end of this email to -rcu
> > branch dev, then run rcutorture as follows:
> > 
> > nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop"
> > 
> > This resulted in the console output that I placed here:
> > 
> > http://www2.rdrop.com/~paulmck/submission/console.log.gz
> > 
> > But I don't see calls to sched_setaffinity() or migration_cpu_stop().
> > Steve, is something else needed on the kernel command line in addition to
> > the following?
> > 
> > ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop
> 
> Do you have function graph enabled in the config?
> 
> [    2.098303] ftrace bootup tracer 'function_graph' not registered.

I guess I don't!  Thank you, will fix.

Let's see...

My .config has CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y.  It looks like I
need CONFIG_FUNCTION_GRAPH_TRACER=y, which I don't have.  And it looks
like that needs CONFIG_FUNCTION_TRACER=y, which I also don't have.
But I do have CONFIG_HAVE_FUNCTION_TRACER=y.  So I should add this
to my rcutorture command line:

--kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y".

I fired this up.  Here is hoping!  ;-)

And it does have sched_setaffinity(), woo-hoo!!!  I overwrote the old file:

	http://www2.rdrop.com/~paulmck/submission/console.log.gz

							Thanx, Paul


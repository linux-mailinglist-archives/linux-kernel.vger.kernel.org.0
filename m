Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C64486BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 22:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390212AbfHHUvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 16:51:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730678AbfHHUvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:51:36 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78KfsJU025933
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 16:51:35 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u8rchxqjw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:51:34 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Aug 2019 21:51:33 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 21:51:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78KpSXn41615806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 20:51:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57016B2064;
        Thu,  8 Aug 2019 20:51:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28BABB2065;
        Thu,  8 Aug 2019 20:51:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 20:51:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8406016C9A2E; Thu,  8 Aug 2019 13:51:29 -0700 (PDT)
Date:   Thu, 8 Aug 2019 13:51:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190808102610.GA7227@X58A-UD3R>
 <20190808181112.GQ28441@linux.ibm.com>
 <20190808201333.GE261256@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808201333.GE261256@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080820-0072-0000-0000-000004514DF5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011571; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01244002; UDB=6.00656283; IPR=6.01025480;
 MB=3.00028097; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-08 20:51:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080820-0073-0000-0000-00004CC25693
Message-Id: <20190808205129.GU28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 04:13:33PM -0400, Joel Fernandes wrote:
> On Thu, Aug 08, 2019 at 11:11:12AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 08, 2019 at 07:26:10PM +0900, Byungchul Park wrote:
> > > On Wed, Aug 07, 2019 at 05:45:04AM -0400, Joel Fernandes wrote:
> > > > On Tue, Aug 06, 2019 at 04:56:31PM -0700, Paul E. McKenney wrote:
> > > 
> > > [snip]
> > > 
> > > > > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> > > > > Of course, I am hoping that a later patch uses an array of pointers built
> > > > > at kfree_rcu() time, similar to Rao's patch (with or without kfree_bulk)
> > > > > in order to reduce per-object cache-miss overhead.  This would make it
> > > > > easier for callback invocation to keep up with multi-CPU kfree_rcu()
> > > > > floods.
> > > > 
> > > > I think Byungchul tried an experiment with array of pointers and wasn't
> > > > immediately able to see a benefit. Perhaps his patch needs a bit more polish
> > > > or another test-case needed to show benefit due to cache-misses, and the perf
> > > > tool could be used to show if cache misses were reduced. For this initial
> > > > pass, we decided to keep it without the array optimization.
> > > 
> > > I'm still seeing no improvement with kfree_bulk().
> > > 
> > > I've been thinking I could see improvement with kfree_bulk() because:
> > > 
> > >    1. As you guys said, the number of cache misses will be reduced.
> > >    2. We can save (N - 1) irq-disable instructions while N kfrees.
> > >    3. As Joel said, saving/restoring CPU status that kfree() does inside
> > >       is not required.
> > > 
> > > But even with the following patch applied, the result was same as just
> > > batching test. We might need to get kmalloc objects from random
> > > addresses to maximize the result when using kfree_bulk() and this is
> > > even closer to real practical world too.
> > > 
> > > And the second and third reasons doesn't seem to work as much as I
> > > expected.
> > > 
> > > Do you have any idea? Or what do you think about it?
> > 
> > I would not expect kfree_batch() to help all that much unless the
> > pre-grace-period kfree_rcu() code segregated the objects on a per-slab
> > basis.
> 
> You mean kfree_bulk() instead of kfree_batch() right? I agree with you, would
> be nice to do per-slab optimization in the future.

Indeed I do mean kfree_bulk()!  One of those mornings, I guess...

But again, without the per-slab locality, I doubt that we will see much
improvement from kfree_bulk() over kfree().

> Also, I am thinking that whenever we do per-slab optimization, then the
> kmem_cache_free_bulk() can be optimized further. If all pointers are on the
> same slab, then we can just do virt_to_cache on the first pointer and avoid
> repeated virt_to_cache() calls. That might also give a benefit -- but I could
> be missing something.

A sort might be required to make that work nicely, which would add some
overhead.  Probably not that much, though, the increased locality would
have a fighting chance of overcoming the sort's overhead.

> Right now kmem_cache_free_bulk() just looks like a kmem_cache_free() in a
> loop except the small benefit of not disabling/enabling IRQs across each
> __cache_free, and the reduced cache miss benefit of using the array.

C'mon!  Show some respect for the awesome power of temporal locality!!!  ;-)

							Thanx, Paul


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE54B99E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 15:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfFSNT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 09:19:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFSNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:
        Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=enh7bl+ZxtCNZahENTVUATMuvV2PoiZCx+Kx0tLEQaw=; b=Kr8dO+mJQItzeFRoa+XrWjaxK
        gxUaCZCEGKifi3deIdGTCCX0ciZdqBxSxhcwil6aLbl7xkMiFQ/mA8DY931XJUKnnP4ufE0ZdnnIm
        gg5BKrLLYparVAKkpWVZFdzC8vdTbN0t3yJgrlqMDasJrKWQFTCMrXQLBphgEL56XDSZHWWJ6JnQ9
        W5ZsfB3LX39EGRzdBXgDmxT63thYXtKBOw2SbTTn8RD5b1q1QZhEgpqaVW/JNwFjNZVzHDmpS2Sdz
        fWjlhdZ9g7eZstLTeyVv3ZU4LkMqzHCBPcbROdJE9Xz/TM5CyW529G/BPvtJyktoAuFWOT5TXvFKr
        FsmbQB85w==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdaUo-0000KD-7U; Wed, 19 Jun 2019 13:19:26 +0000
Date:   Wed, 19 Jun 2019 10:19:22 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Message-ID: <20190619101922.04340605@coco.lan>
In-Reply-To: <20190619114356.GP3419@hirez.programming.kicks-ass.net>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
        <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
        <20190619114356.GP3419@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(c/c list cleaned)

Em Wed, 19 Jun 2019 13:43:56 +0200
Peter Zijlstra <peterz@infradead.org> escreveu:

> On Tue, Jun 18, 2019 at 05:53:17PM -0300, Mauro Carvalho Chehab wrote:
> 
> >  .../{ => driver-api}/atomic_bitops.rst        |  2 -  
> 
> That's a .txt file, big fat NAK for making it an rst.

Rst is a text file. This one is parsed properly by Sphinx without
any changes.

> 
> >  .../{ => driver-api}/futex-requeue-pi.rst     |  2 -  
> 
> >  .../{ => driver-api}/gcc-plugins.rst          |  2 -  
> 
> >  Documentation/{ => driver-api}/kprobes.rst    |  2 -
> >  .../{ => driver-api}/percpu-rw-semaphore.rst  |  2 -  
> 
> More NAK for rst conversion

Again, those don't need any conversion. Those files already parse 
as-is by Sphinx, with no need for any change.

The only change here is that, on patch 1/22, the files that
aren't listed on an index file got a :orphan: added in order
to make this explicit. This patch removes it.

> 
> >  Documentation/{ => driver-api}/pi-futex.rst   |  2 -
> >  .../{ => driver-api}/preempt-locking.rst      |  2 -  
> 
> >  Documentation/{ => driver-api}/rbtree.rst     |  2 -  
> 
> >  .../{ => driver-api}/robust-futex-ABI.rst     |  2 -
> >  .../{ => driver-api}/robust-futexes.rst       |  2 -  
> 
> >  .../{ => driver-api}/speculation.rst          |  8 +--
> >  .../{ => driver-api}/static-keys.rst          |  2 -  
> 
> >  .../{ => driver-api}/this_cpu_ops.rst         |  2 -  
> 
> >  Documentation/locking/rt-mutex.rst            |  2 +-  
> 
> NAK. None of the above have anything to do with driver-api.

Ok. Where do you think they should sit instead? core-api?

Thanks,
Mauro

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA458639A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 18:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfGIQnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 12:43:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfGIQnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:43:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C540A3EB2;
        Tue,  9 Jul 2019 16:43:13 +0000 (UTC)
Received: from treble (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43CA35C2FC;
        Tue,  9 Jul 2019 16:43:11 +0000 (UTC)
Date:   Tue, 9 Jul 2019 11:43:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jul 9 (objtool)
Message-ID: <20190709164308.33gzhuu6xtqy32jb@treble>
References: <20190709220008.42ef7b47@canb.auug.org.au>
 <660371c5-60e9-2882-8993-21edc5e3814c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <660371c5-60e9-2882-8993-21edc5e3814c@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 09 Jul 2019 16:43:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:07:09AM -0700, Randy Dunlap wrote:
> On 7/9/19 5:00 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20190708:
> > 
> 
> on x86_64, with an older gcc:  gcc (SUSE Linux) 4.8.5
> 
> some builds (3) say:
> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0xb2: sibling call from callable instruction with modified stack frame
> (see core.o.r6235)
> 
> and one build says:
> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x2a: can't find switch jump table
> (see core.o.r6238)

Still working on it.

-- 
Josh

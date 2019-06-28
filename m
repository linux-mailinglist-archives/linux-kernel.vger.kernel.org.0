Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A639F58EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 02:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfF1AWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 20:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfF1AWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:22:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4989DC057E65;
        Fri, 28 Jun 2019 00:22:13 +0000 (UTC)
Received: from treble (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07713600CC;
        Fri, 28 Jun 2019 00:22:11 +0000 (UTC)
Date:   Thu, 27 Jun 2019 19:22:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        elftoolchain-developers@lists.sourceforge.net
Subject: Re: [PATCH 1/2] objtool: Rename elf_open to prevent conflict with
 libelf from elftoolchain
Message-ID: <20190628002208.v6brs6b6hf7b6sth@treble>
References: <20190616231500.8572-1-mforney@mforney.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190616231500.8572-1-mforney@mforney.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 28 Jun 2019 00:22:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 04:14:59PM -0700, Michael Forney wrote:
> Signed-off-by: Michael Forney <mforney@mforney.org>
> ---
>  tools/objtool/check.c | 2 +-
>  tools/objtool/elf.c   | 2 +-
>  tools/objtool/elf.h   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Sorry for the delay, I was out for a bit and I'm still trying to get
caught back up on email.

These patches look fine.  I'll try to send them on to the -tip tree
shortly.

Just curious, have you done much testing with the elftoolchain version
of libelf and objtool?  So far objtool has only been successfully used
with the elfutils version, so I'm just curious how compatible your
libelf is with the elfutils version.

-- 
Josh

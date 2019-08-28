Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC136A05C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 17:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfH1PKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 11:10:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfH1PKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:10:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F049487521D;
        Wed, 28 Aug 2019 15:10:06 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B57617B66;
        Wed, 28 Aug 2019 15:10:06 +0000 (UTC)
Date:   Wed, 28 Aug 2019 10:10:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: next-20190826 - objtool fails to build.
Message-ID: <20190828151003.3px5plk4tp2s5s5c@treble>
References: <133250.1566965715@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <133250.1566965715@turing-police>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 28 Aug 2019 15:10:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 12:15:15AM -0400, Valdis Klētnieks wrote:
> OK.  I'm mystified.  next-20190806 built fine.  -0818 and -0826 died a
> glorious death indeed.  All 3 were build using the same Fedora Rawhide 9.1.1
> compiler (installed on July 30). 'git log -- tools/objtool' comes up empty.
> 
> Local hack-around was to remove the -Werror from tools/objtool/Makefile
> 
> Am particularly mystified by the errors on lines 808/809 - the same compiler that
> was happy with the same code in next-0806 is now upset.  The others could possibly
> be a stray typedef in an include someplace, but those two errors have me stumped.
> 
> For that matter, I'm not even seeing how -Wsign-compare was even getting set, given
> a command 'make' and not W=1 or W=2....
> 
> (cue twilight zone theme)

Weird.  I don't have access to Rawhide at the moment so I can't
recreate.  It builds fine for me on Fedora 29.

But I don't see how those warnings could get enabled: -Wsign-compare
-Wunused-parameter.

Can you "make clean" and do "make V=1 tools/objtool" to show the actual
flags?

The reported warnings do seem reasonable though, maybe we should fix
them regardless and explicitly enable the warnings.

-- 
Josh

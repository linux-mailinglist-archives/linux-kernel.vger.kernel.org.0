Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F65B79B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 14:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbfISMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 08:49:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36500 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387520AbfISMtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:49:24 -0400
Received: from nazgul.tnic (unknown [193.86.95.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 039051EC04BC;
        Thu, 19 Sep 2019 14:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568897363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SvivuKiDv8mVFUG8Dwck4C5w7ji5KE7vzCHmIg2WcWA=;
        b=Gm83Egjv2y3IHZ04hPe2qsDYEgMJriGC4xoXzWN3ngcLi7Koh2ogXS7vrbWty0heJ+fDmi
        azz3rpDWHqDXmn6pBaIhSPsV5nAemg/PVcripkux1vbO/EgG+9A9rGJfnq+vFt5b40Z5ws
        oOojf3v2beto+6aJgr//DYM1SQe2uzY=
Date:   Thu, 19 Sep 2019 14:49:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improve memset
Message-ID: <20190919124911.GA18148@nazgul.tnic>
References: <20190913072237.GA12381@zn.tnic>
 <20190917201021.evoxxj7vkcb45rpg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190917201021.evoxxj7vkcb45rpg@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:10:21PM -0500, Josh Poimboeuf wrote:
> Then the "reverse alternatives" feature wouldn't be needed anyway.

The intent was to have the default, most-used version be there at
build-time, obviating the need to patch. Therefore on those old !ERMS
CPUs we'll end up doing rep;stosb before patching, which is supported,
albeit slow.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

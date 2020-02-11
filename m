Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9972A158B70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 09:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgBKIsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 03:48:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:47578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbgBKIsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:48:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62C06B2F6;
        Tue, 11 Feb 2020 08:48:09 +0000 (UTC)
Date:   Tue, 11 Feb 2020 09:47:57 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] objtool: Add relocation check for alternative
 sections
Message-ID: <20200211084757.GA31812@zn.tnic>
References: <cover.1581359535.git.jpoimboe@redhat.com>
 <7b90b68d093311e4e8f6b504a9e1c758fd7e0002.1581359535.git.jpoimboe@redhat.com>
 <CAHk-=wgN0RtGNnYHjnaxtjO3BxL=t-nTUnEEwZu5J--BDhb95A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgN0RtGNnYHjnaxtjO3BxL=t-nTUnEEwZu5J--BDhb95A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:51:44PM -0800, Linus Torvalds wrote:
> On Mon, Feb 10, 2020 at 10:33 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> LGTM. Did this actually find anything? And if not, did you verify that
> it would by intentionally creating a bad alternative (perhaps the
> broken one from my patch?)

Yeah, we used your patch while playing with this. Lemme do some builds
with this and see what fires. Nothing should, I would strongly assume.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

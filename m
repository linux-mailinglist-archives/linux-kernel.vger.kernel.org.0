Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87E01BC55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 19:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbfEMRx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 13:53:57 -0400
Received: from namei.org ([65.99.196.166]:38872 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbfEMRx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:53:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4DHrsbi002989;
        Mon, 13 May 2019 17:53:54 GMT
Date:   Tue, 14 May 2019 03:53:54 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
In-Reply-To: <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1905140352370.14684@namei.org>
References: <alpine.LRH.2.21.1905110801350.9392@namei.org> <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2019, Linus Torvalds wrote:

> On Fri, May 10, 2019 at 6:09 PM James Morris <jmorris@namei.org> wrote:
> >
> > These patches include fixes to enable fuzz testing, and a fix for
> > calculating whether a filesystem is user-modifiable.
> 
> So now these have been very recently rebased (on top of a random
> merge-window "tree of the day" version) instead of having multiple
> merges.
> 
> That makes the history cleaner, but has its own issues.

These are just plain patches from the author, they were not part of any 
publicly accessible tree -- there's nowhere they could be merged from.

> We really need to find a different model for the security layer patches.
> 
>                    Linus
> 

-- 
James Morris
<jmorris@namei.org>


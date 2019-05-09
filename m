Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F33D219525
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 00:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfEIWT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 18:19:57 -0400
Received: from namei.org ([65.99.196.166]:38378 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfEIWT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:19:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x49MJtYU014529;
        Thu, 9 May 2019 22:19:55 GMT
Date:   Fri, 10 May 2019 08:19:55 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] security subsytem: TPM changes for v5.2
In-Reply-To: <CAHk-=whqzNFfeNOouBjH2GKMVgMi22fsNOaCgbUOnCPmKmEXeQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1905100819390.13541@namei.org>
References: <alpine.LRH.2.21.1905100320110.25349@namei.org> <CAHk-=whqzNFfeNOouBjH2GKMVgMi22fsNOaCgbUOnCPmKmEXeQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019, Linus Torvalds wrote:

> On Thu, May 9, 2019 at 10:23 AM James Morris <jmorris@namei.org> wrote:
> >
> > Bugfixes and new selftests for v5.1 features (partial reads in /dev/tpm0).
> 
> What the heck is going on?
> 
> I got all of these long ago in the "TPM fixes" branch for 5.1. One
> month ago, merge commit a556810d8e06.
> 
> These are just rebased (!) copies of stuff I already have, and they should
> 
>  (a) never have been rebased in the first place
> 
>  (b) certainly not be re-sent to me as a new branch
> 
> Please throw this branch away and make sure it really is dead and
> buried and never shows up again.

Yikes, ok.

> And take a moment to look at what happened and why this broken branch
> was duplicated and sent twice!

Could it be something I pulled in? I haven't used 'rebase' in many years.


-- 
James Morris
<jmorris@namei.org>


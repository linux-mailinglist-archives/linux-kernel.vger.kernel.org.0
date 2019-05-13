Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C081BD22
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 20:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfEMSWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 14:22:53 -0400
Received: from namei.org ([65.99.196.166]:38910 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfEMSWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:22:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4DIMpN5005114;
        Mon, 13 May 2019 18:22:52 GMT
Date:   Tue, 14 May 2019 04:22:51 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
In-Reply-To: <alpine.LRH.2.21.1905140352370.14684@namei.org>
Message-ID: <alpine.LRH.2.21.1905140421360.4757@namei.org>
References: <alpine.LRH.2.21.1905110801350.9392@namei.org> <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com> <alpine.LRH.2.21.1905140352370.14684@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019, James Morris wrote:

> On Sat, 11 May 2019, Linus Torvalds wrote:

> > So now these have been very recently rebased (on top of a random
> > merge-window "tree of the day" version) instead of having multiple
> > merges.
> > 
> > That makes the history cleaner, but has its own issues.
> 
> These are just plain patches from the author, they were not part of any 
> publicly accessible tree -- there's nowhere they could be merged from.

The reason I created a new branch in this case was that the existing one 
had the same issue as the TPM branch. 

-- 
James Morris
<jmorris@namei.org>


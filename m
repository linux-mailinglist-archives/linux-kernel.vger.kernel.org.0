Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2671226ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 21:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfEVTTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 15:19:23 -0400
Received: from namei.org ([65.99.196.166]:33844 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbfEVTTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:19:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4MJJFlT023718;
        Wed, 22 May 2019 19:19:15 GMT
Date:   Thu, 23 May 2019 05:19:15 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
cc:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Turn lockdown into an LSM
In-Reply-To: <14ed1f30-a1d0-f973-5c8c-241337c8fc09@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1905230457000.18826@namei.org>
References: <20190521224013.3782-1-matthewgarrett@google.com> <alpine.LRH.2.21.1905221203070.3967@namei.org> <CACdnJuuTR=Ut4giPKC=kdxgY9yPv8+3PZyEzuxvON3Jr_92XnQ@mail.gmail.com> <CALCETrVow8U=xhQdJt8kSMX16Lf0Mstf3+QxY4iz4DHVp=PYWA@mail.gmail.com>
 <14ed1f30-a1d0-f973-5c8c-241337c8fc09@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Stephen Smalley wrote:

> That seems to violate the intent of lockdown as I understood it, and 
> turns security_is_locked_down() into a finer-grained capable() call. 
> Also, if I understand correctly, this could only be done if one were to 
> disable the lockdown module in the lsm list, since the security 
> framework will return non-zero (i.e. the operation is locked down) if 
> any module that implements the hook returns non-zero; LSM is 
> "restrictive". At that point SELinux or the other LSM would be the sole 
> arbiter of lockdown decisions. SELinux or the other LSM also wouldn't 
> have access to the kernel_locked_down level unless that was exported in 
> some manner from the lockdown module.  Not sure how to compose these.

Right, I was envisaging the LSM replacing the default.

i.e. the default is tristate OR fine grained LSM policy.

They could in theory be composed restrictively, but this is likely not 
useful given the coarse grained default policy.  All the LSM could do is 
either further restrict none or integrity.

We'd need to figure out how to avoid confusing users in the case where 
multiple LSMs are registered for the hooks, possibly by having the 
lockdown LSM gate this and update the securityfs lockdown node with 
something like "lsm:smack".


-- 
James Morris
<jmorris@namei.org>


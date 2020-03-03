Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67C1772D0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 10:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgCCJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 04:45:27 -0500
Received: from ozlabs.org ([203.11.71.1]:55693 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgCCJp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:45:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48WsZD4YDzz9sRN;
        Tue,  3 Mar 2020 20:45:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1583228724;
        bh=Wo5bQeKUPhAri+IWkOD5PZEI0f97+gdXT92XXJeUOaY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FvTeVOpG1HL369swVAGKwuZdqRj3BH9QUPT5UA/ZR7E5xAuX9Esj/AXStB1Ufwp/o
         QjA2R3+CuKGBGHH3MqixMIW38v3h0eUpP5sxQQWxA0p6yPZdapZMWwxaXwGjaWVSHt
         zK0R/sxz/ci+xcCJvVi3zbBt0Rrv0T/jAZ7jt1PXRDPS3OHKqT7hY/Rl0cxnygArbk
         zv2DhYTyCO9oVaS+AhI3jBya3LfjhHJw2ZG/CuvBjZ3gAJ2zpo00YD2XR3nIFgpgJr
         ot9rVNJKqYM69dM4qti8YMpiXwlagy+JcXiObIoaRe3hmrALaOVbi2xxlyDej5Ppmp
         pZb/DytQtWifA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 2/6] powerpc: kvm: no need to check return value of debugfs_create functions
In-Reply-To: <20200303085039.GA1323622@kroah.com>
References: <20200209105901.1620958-1-gregkh@linuxfoundation.org> <20200209105901.1620958-2-gregkh@linuxfoundation.org> <87imjlswxc.fsf@mpe.ellerman.id.au> <20200303085039.GA1323622@kroah.com>
Date:   Tue, 03 Mar 2020 20:45:23 +1100
Message-ID: <87d09tsrf0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Tue, Mar 03, 2020 at 06:46:23PM +1100, Michael Ellerman wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> > When calling debugfs functions, there is no need to ever check the
>> > return value.  The function can work or not, but the code logic should
>> > never do something different based on this.
>> 
>> Except it does need to do something different, if the file was created
>> it needs to be removed in the remove path.
>> 
>> > diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
>> > index bfe4f106cffc..8e4791c6f2af 100644
>> > --- a/arch/powerpc/kvm/timing.c
>> > +++ b/arch/powerpc/kvm/timing.c
>> > @@ -207,19 +207,12 @@ static const struct file_operations kvmppc_exit_timing_fops = {
>> >  void kvmppc_create_vcpu_debugfs(struct kvm_vcpu *vcpu, unsigned int id)
>> >  {
>> >  	static char dbg_fname[50];
>> > -	struct dentry *debugfs_file;
>> >  
>> >  	snprintf(dbg_fname, sizeof(dbg_fname), "vm%u_vcpu%u_timing",
>> >  		 current->pid, id);
>> > -	debugfs_file = debugfs_create_file(dbg_fname, 0666,
>> > -					kvm_debugfs_dir, vcpu,
>> > -					&kvmppc_exit_timing_fops);
>> > -
>> > -	if (!debugfs_file) {
>> > -		printk(KERN_ERR"%s: error creating debugfs file %s\n",
>> > -			__func__, dbg_fname);
>> > -		return;
>> > -	}
>> > +	debugfs_create_file(dbg_fname, 0666, kvm_debugfs_dir, vcpu,
>> > +			    &kvmppc_exit_timing_fops);
>> > +
>> >  
>> >  	vcpu->arch.debugfs_exit_timing = debugfs_file;
>
> Ugh, you are right, how did I miss that?  How is 0-day missing this?
> It's been in my tree for a long time, odd.

This code isn't enabled by default, or in any defconfig. So it's only
allmodconfig that would trip it, I guess 0-day isn't doing powerpc
allmodconfig builds.

>> I squashed this in, which seems to work:
...
>>  
>>  void kvmppc_remove_vcpu_debugfs(struct kvm_vcpu *vcpu)
>>  {
>> -       if (vcpu->arch.debugfs_exit_timing) {
>> +       if (!IS_ERR_OR_NULL(vcpu->arch.debugfs_exit_timing)) {
>>                 debugfs_remove(vcpu->arch.debugfs_exit_timing);
>>                 vcpu->arch.debugfs_exit_timing = NULL;
>>         }
>
> No, this can just be:
> 	debugfs_remove(vcpu->arch.debugfs_exit_timing);
>
> No need to check anything, just call it and the debugfs code can handle
> it just fine.

Oh duh, of course, I should have checked.

I'd still like to NULL out the debugfs_exit_timing member, so I'll do:

void kvmppc_remove_vcpu_debugfs(struct kvm_vcpu *vcpu)
{
	debugfs_remove(vcpu->arch.debugfs_exit_timing);
	vcpu->arch.debugfs_exit_timing = NULL;
}


cheers

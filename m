Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78067FC43
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 16:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394948AbfHBOca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 10:32:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389189AbfHBOca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:32:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B82AF1570;
        Fri,  2 Aug 2019 07:32:29 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FE283F575;
        Fri,  2 Aug 2019 07:32:28 -0700 (PDT)
Subject: Re: [PATCH] arm64/kvm: fix -Wimplicit-fallthrough warnings
To:     Qian Cai <cai@lca.pw>
Cc:     james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, christoffer.dall@linaro.org,
        drjones@redhat.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1564755788-28485-1-git-send-email-cai@lca.pw>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <0361d2e8-e57c-5cac-f0ff-5e56675ba71d@kernel.org>
Date:   Fri, 2 Aug 2019 15:32:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564755788-28485-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2019 15:23, Qian Cai wrote:
> The commit a892819560c4 ("KVM: arm64: Prepare to handle deferred
> save/restore of 32-bit registers") introduced vcpu_write_spsr32() but
> seems forgot to add "break" between the switch statements and generates
> compilation warnings below. Also, adding a default statement as in
> vcpu_read_spsr32().

See
https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/commit/?id=3d584a3c85d6fe2cf878f220d4ad7145e7f89218

The default statement is pretty pointless by construction.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...

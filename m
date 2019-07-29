Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86018788E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 11:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfG2Jw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 05:52:27 -0400
Received: from foss.arm.com ([217.140.110.172]:41002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbfG2JwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:52:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E4121596;
        Mon, 29 Jul 2019 02:52:25 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40F703F694;
        Mon, 29 Jul 2019 02:52:24 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: vgic-v3: mark expected switch fall-through
To:     Matteo Croce <mcroce@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20190728233347.7856-1-mcroce@redhat.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <e59eb35f-a83b-69e4-c72f-fe3f674f1fec@kernel.org>
Date:   Mon, 29 Jul 2019 10:52:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728233347.7856-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2019 00:33, Matteo Croce wrote:
> Mark switch cases where we are expecting to fall through,
> fixes the following warning:
> 
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c: In function ‘__vgic_v3_save_aprs’:
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:351:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cpu_if->vgic_ap0r[2] = __vgic_v3_read_ap0rn(2);
>    ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:352:2: note: here
>   case 6:
>   ^~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:353:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cpu_if->vgic_ap0r[1] = __vgic_v3_read_ap0rn(1);
>    ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:354:2: note: here
>   default:
>   ^~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:361:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cpu_if->vgic_ap1r[2] = __vgic_v3_read_ap1rn(2);
>    ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:362:2: note: here
>   case 6:
>   ^~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:363:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cpu_if->vgic_ap1r[1] = __vgic_v3_read_ap1rn(1);
>    ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:364:2: note: here
>   default:
>   ^~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c: In function ‘__vgic_v3_restore_aprs’:
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:384:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    __vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[2], 2);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:385:2: note: here
>   case 6:
>   ^~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:386:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    __vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[1], 1);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:387:2: note: here
>   default:
>   ^~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:394:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    __vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[2], 2);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:395:2: note: here
>   case 6:
>   ^~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:396:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    __vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[1], 1);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:397:2: note: here
>   default:
>   ^~~~~~~
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  virt/kvm/arm/hyp/vgic-v3-sr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> index 254c5f190a3d..622fb4d18c5c 100644
> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> @@ -349,8 +349,10 @@ void __hyp_text __vgic_v3_save_aprs(struct kvm_vcpu *vcpu)
>  	case 7:
>  		cpu_if->vgic_ap0r[3] = __vgic_v3_read_ap0rn(3);
>  		cpu_if->vgic_ap0r[2] = __vgic_v3_read_ap0rn(2);
> +		/* fallthrough */
>  	case 6:
>  		cpu_if->vgic_ap0r[1] = __vgic_v3_read_ap0rn(1);
> +		/* fallthrough */
>  	default:
>  		cpu_if->vgic_ap0r[0] = __vgic_v3_read_ap0rn(0);
>  	}
> @@ -359,8 +361,10 @@ void __hyp_text __vgic_v3_save_aprs(struct kvm_vcpu *vcpu)
>  	case 7:
>  		cpu_if->vgic_ap1r[3] = __vgic_v3_read_ap1rn(3);
>  		cpu_if->vgic_ap1r[2] = __vgic_v3_read_ap1rn(2);
> +		/* fallthrough */
>  	case 6:
>  		cpu_if->vgic_ap1r[1] = __vgic_v3_read_ap1rn(1);
> +		/* fallthrough */
>  	default:
>  		cpu_if->vgic_ap1r[0] = __vgic_v3_read_ap1rn(0);
>  	}
> @@ -382,8 +386,10 @@ void __hyp_text __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu)
>  	case 7:
>  		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[3], 3);
>  		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[2], 2);
> +		/* fallthrough */
>  	case 6:
>  		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[1], 1);
> +		/* fallthrough */
>  	default:
>  		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[0], 0);
>  	}
> @@ -392,8 +398,10 @@ void __hyp_text __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu)
>  	case 7:
>  		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[3], 3);
>  		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[2], 2);
> +		/* fallthrough */
>  	case 6:
>  		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[1], 1);
> +		/* fallthrough */
>  	default:
>  		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[0], 0);
>  	}
> 

Already fixed here[1].

	M.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/commit/?id=1a8248c74c81a15a32dc3344fb5c622e19072791
-- 
Jazz is not dead, it just smells funny...

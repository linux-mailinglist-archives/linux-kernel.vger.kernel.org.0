Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768C376F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbfGZQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 12:49:44 -0400
Received: from foss.arm.com ([217.140.110.172]:47346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387437AbfGZQto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:49:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0946337;
        Fri, 26 Jul 2019 09:49:43 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ABA33F71F;
        Fri, 26 Jul 2019 09:49:42 -0700 (PDT)
Subject: Re: [PATCH] arm64/kexec: Use consistent convention of initializing
 'kxec_buf.mem' with KEXEC_BUF_MEM_UNKNOWN
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, takahiro.akashi@linaro.org,
        will.deacon@arm.com
References: <1562846252-7441-1-git-send-email-bhsharma@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <839b08dc-36ae-fb94-0c0a-00e6ee8a5790@arm.com>
Date:   Fri, 26 Jul 2019 17:49:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562846252-7441-1-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 11/07/2019 12:57, Bhupesh Sharma wrote:
> With commit b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()"),
> we introduced the KEXEC_BUF_MEM_UNKNOWN macro. If kexec_buf.mem is set
> to this value, kexec_locate_mem_hole() will try to allocate free memory.
> 
> While other arch(s) like s390 and x86_64 already use this macro to
> initialize kexec_buf.mem with, arm64 uses an equivalent value of 0.
> Replace it with KEXEC_BUF_MEM_UNKNOWN, to keep the convention of
> initializing 'kxec_buf.mem' consistent across various archs.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

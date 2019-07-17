Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF3D6B5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 06:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfGQE6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 00:58:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:51690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfGQE6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:58:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7615EABCD;
        Wed, 17 Jul 2019 04:58:46 +0000 (UTC)
Subject: Re: [PATCH v8 4/5] x86/paravirt: Remove const mark from
 x86_hyper_xen_hvm variable
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, sstabellini@kernel.org, x86@kernel.org,
        tglx@linutronix.de, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, mingo@redhat.com
References: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <eb67c985-0d1f-641c-9622-e0faf3e72b8d@suse.com>
Date:   Wed, 17 Jul 2019 06:58:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.19 06:26, Zhenzhong Duan wrote:
> .. as "nopv" support needs it to be changeable at boot up stage.
> 
> Checkpatch reports warning, so move variable declarations from
> hypervisor.c to hypervisor.h
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>

... and complete series applied to xen/tip.git for-linus-5.3a


Juergen

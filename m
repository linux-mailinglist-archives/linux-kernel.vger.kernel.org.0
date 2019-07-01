Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6457450B73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfFXNHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 09:07:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:45116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728822AbfFXNHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:07:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 363C4AFAC;
        Mon, 24 Jun 2019 13:06:59 +0000 (UTC)
Subject: Re: [PATCH 1/6] x86/xen: Mark xen_hvm_need_lapic() and
 xen_hvm_need_lapic() as __init
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org
References: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <49f5293c-f9da-20ee-9297-65c663fd43b2@suse.com>
Date:   Mon, 24 Jun 2019 15:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.19 15:01, Zhenzhong Duan wrote:
> .. as they are only called at early bootup stage. In fact, other
> functions in x86_hyper_xen_hvm.init.* are all marked as __init.
> 
> Unexport xen_hvm_need_lapic as it's never used outside.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

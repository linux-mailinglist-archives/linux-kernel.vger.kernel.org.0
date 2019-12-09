Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D601166E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 07:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfLIGZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 01:25:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:52388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbfLIGZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:25:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5493CAFAE;
        Mon,  9 Dec 2019 06:25:41 +0000 (UTC)
Subject: Re: [PATCH v2 10/14] driver: xen: Replace cpu_up/down with
 device_online/offline
To:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-11-qais.yousef@arm.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <ff1486b7-1072-b4a6-ff51-1d5861d2c17b@suse.com>
Date:   Mon, 9 Dec 2019 07:25:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191125112754.25223-11-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.19 12:27, Qais Yousef wrote:
> The core device API performs extra housekeeping bits that are missing
> from directly calling cpu_up/down.
> 
> See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> serialization during LPM") for an example description of what might go
> wrong.
> 
> This also prepares to make cpu_up/down a private interface for anything
> but the cpu subsystem.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

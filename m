Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3311295A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 11:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfLDKgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 05:36:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLDKge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:36:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60BBDB164;
        Wed,  4 Dec 2019 10:36:32 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] xen/xenbus: reference count registered modules
To:     Paul Durrant <pdurrant@amazon.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191202114117.1264-1-pdurrant@amazon.com>
 <20191202114117.1264-2-pdurrant@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <d6998d80-99f1-ffa4-f4cf-5c9bb938587d@suse.com>
Date:   Wed, 4 Dec 2019 11:36:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202114117.1264-2-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.19 12:41, Paul Durrant wrote:
> To prevent a PV driver module being removed whilst attached to its other
> end, and hence xenbus calling into potentially invalid text, take a
> reference on the module before calling the probe() method (dropping it if
> unsuccessful) and drop the reference after returning from the remove()
> method.
> 
> Suggested-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Pushed to xen/tip.git for-linus-5.5b


Juergen

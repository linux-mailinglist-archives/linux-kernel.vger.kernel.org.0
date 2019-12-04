Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C2911295E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 11:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfLDKg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 05:36:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:40110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLDKg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:36:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71EC2B25E;
        Wed,  4 Dec 2019 10:36:54 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] xen-blkback: allow module to be cleanly unloaded
To:     Paul Durrant <pdurrant@amazon.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20191202114117.1264-1-pdurrant@amazon.com>
 <20191202114117.1264-3-pdurrant@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <db120726-1347-438d-7bd7-737380641960@suse.com>
Date:   Wed, 4 Dec 2019 11:36:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202114117.1264-3-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.19 12:41, Paul Durrant wrote:
> Add a module_exit() to perform the necessary clean-up.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> Reviewed-by: "Roger Pau Monné" <roger.pau@citrix.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Pushed to xen/tip.git for-linus-5.5b


Juergen

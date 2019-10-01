Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC379C2B26
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 02:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbfJAAC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 20:02:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32908 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfJAAC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 20:02:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 916F328A824
Subject: Re: [PATCH 1/1] blk-mq: fill header with kernel-doc
To:     minwoo.im@samsung.com
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
References: <20190930194846.23141-1-andrealmeid@collabora.com>
 <CGME20190930211400epcas2p4253bdc8cc3630f87d7e955cd23fdf1f2@epcms2p6>
 <20190930215456epcms2p64c66823d97c6ffad3861e750a4145f4b@epcms2p6>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <d6e2987a-3278-891c-8aa2-a03af08ffda5@collabora.com>
Date:   Mon, 30 Sep 2019 21:01:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930215456epcms2p64c66823d97c6ffad3861e750a4145f4b@epcms2p6>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 6:54 PM, Minwoo Im wrote:
> Hi André,
> 
>> -/*
>> +/**
>> + * blk_mq_rq_from_pdu - cast a PDU to a request
>> + * @pdu: the PDU (protocol unit request) to be casted
> 
> It makes sense, but it looks like PDU stands for protocol unit request.
> Could we have it "PDU(Protocol Data Unit)" ?
> 
Ops, thank your for the input :)

> Thanks,
> 
> 


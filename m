Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65147172528
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 18:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgB0Rdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 12:33:52 -0500
Received: from ale.deltatee.com ([207.54.116.67]:56752 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729512AbgB0Rdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:33:52 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1j7N2U-0003wS-Ev; Thu, 27 Feb 2020 10:33:35 -0700
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-8-logang@deltatee.com>
 <becbf34c-e22e-3c48-41df-f23fee2da658@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cc305c27-6974-929f-e90a-510312b9b964@deltatee.com>
Date:   Thu, 27 Feb 2020 10:33:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <becbf34c-e22e-3c48-41df-f23fee2da658@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v11 7/9] nvmet-passthru: Add passthru code to process
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the Review!

On 2020-02-26 4:28 p.m., Sagi Grimberg wrote:
> This looks questionable... There are tons of features that doesn't
> make sense here like hmb, temperature stuff, irq stuff, timestamps,
> reservations etc... passing-through these will have confusing
> semantics.. Maybe white-list what actually makes sense to passthru?

Yes, I agree a white-list here probably makes sense. I'll try to come up
with a list of features to start that whitelist, though my list might be
a bit different from yours: I don't see why temperature or timestamps
can't be passed through.

Also note: Christoph was advocating against the whitelist for the
commands, though, I agree with you that it is the most sensible approach.

>> +        break;
>> +    case nvme_admin_identify:
>> +        switch (req->cmd->identify.cns) {
>> +        case NVME_ID_CNS_CTRL:
>> +            req->execute = nvmet_passthru_execute_cmd;
>> +            req->p.end_req = nvmet_passthru_override_id_ctrl;
>> +            return NVME_SC_SUCCESS;
>> +        case NVME_ID_CNS_NS:
>> +            req->execute = nvmet_passthru_execute_cmd;
>> +            req->p.end_req = nvmet_passthru_override_id_ns;
>> +            return NVME_SC_SUCCESS;
> 
> Aren't you missing NVME_ID_CNS_NS_DESC_LIST? and
> NVME_ID_CNS_NS_ACTIVE_LIST?

Well no, seeing they can be passed through the default path.... But in
the light of the comment below, yes.

>> +        default:
>> +            return nvmet_setup_passthru_command(req);
>> +        }
> 
> Also here, all the namespace management stuff has questionable
> semantics in my mind...

Yes, I agree with that. I'll make the change in the next revision.

Logan

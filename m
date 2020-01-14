Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A813AB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 14:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgANNlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 08:41:14 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:63883 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgANNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:41:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579009273; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=XgsptuF1PzYyDRBhyFpT7E0jFEYQTfHc3/giWQnRSk0=; b=YiMq0hIm3PWeSdkOWJfWo1g1DgeCGFtG24ngSLjAx1iN/+4P4Z/DQEdhHqZqUt/Nqme8OREY
 fgAi2tIt309XZogFhoKKtyedAs9On44B4ZtCluWbQsRxWb6wfTCBggGLe3+28HmNZs793WY+
 UgeJDSjOf5rFzQyOiDFwxd5dxAQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1dc4f4.7f93cbd7bbc8-smtp-out-n02;
 Tue, 14 Jan 2020 13:41:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0C998C447A2; Tue, 14 Jan 2020 13:41:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-19-103-nat.elisa-mobile.fi [85.76.19.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB5F5C43383;
        Tue, 14 Jan 2020 13:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB5F5C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Solar Designer <solar@openwall.com>,
        qize wang <wangqize888888888@gmail.com>
Subject: Re: [PATCH] mwifiex: drop most magic numbers from mwifiex_process_tdls_action_frame()
References: <20191206194535.150179-1-briannorris@chromium.org>
        <0101016eea4fa7f5-e04b23cd-17a0-4306-8100-7761f1161da3-000000@us-west-2.amazonses.com>
        <CA+ASDXNCzyRfZs0D6_+j0Tyqai4PaFk50HpF_LqC-GuOTYJCmA@mail.gmail.com>
Date:   Tue, 14 Jan 2020 15:41:02 +0200
In-Reply-To: <CA+ASDXNCzyRfZs0D6_+j0Tyqai4PaFk50HpF_LqC-GuOTYJCmA@mail.gmail.com>
        (Brian Norris's message of "Mon, 13 Jan 2020 11:05:36 -0800")
Message-ID: <87sgkiqhox.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Mon, Dec 9, 2019 at 2:58 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Brian Norris <briannorris@chromium.org> writes:
>>
>> > AFAICT, the existing commit (1e58252e334d) isn't wrong, per se -- just
>> > very poorly styled -- so this probably doesn't need to go to -stable.
>> > Not sure if it's a candidate for wireless-drivers (where the original
>> > commit currently sites) vs. wireless-drivers-next.
>>
>> I'll try to do so that I'll put this patch to "Awaiting Upstream" state
>> and apply it to w-d-next once 1e58252e334d is merged to w-d-next. Feel
>> free to remind me then that happens :)
>
> It's that time!

Thanks, changed the state to 'Under Review' which means this is back in
my queue.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

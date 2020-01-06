Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 353F2131351
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 15:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgAFOEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 09:04:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgAFOEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:04:54 -0500
Received: from [192.168.0.118] (unknown [49.77.182.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9946C2075A;
        Mon,  6 Jan 2020 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578319493;
        bh=8+kmQXTN3kzWeA8z93aiDVdHZeFlgoRaLfA7PzWAPxk=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=RKXrPaqbwMvah8GOhNZfpGAMQ4bsFYoGsCwd1kp0D14CA4pZnOLJU7MHB2jKdsDyG
         PZLYWsJoWtviAhL5gjLpZOIxnFrtfB8IIzpjKlO9XdqGT/BQd/AiKU2Eh6ORyXByE1
         EMj0E+Bb2eUcZSW9yEOXxdBkQZJqOCCJZAc6kYTw=
Subject: Re: [f2fs-dev] [PATCH] f2fs: show the CP_PAUSE reason in checkpoint
 traces
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
References: <1578021568-21552-1-git-send-email-stummala@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org
From:   Chao Yu <chao@kernel.org>
Message-ID: <83a00e37-bc83-b186-667f-089472d2b1df@kernel.org>
Date:   Mon, 6 Jan 2020 22:04:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1578021568-21552-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-1-3 11:19, Sahitya Tummala wrote:
> Remove the duplicate CP_UMOUNT enum and add the new CP_PAUSE
> enum to show the checkpoint reason in the trace prints.
>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

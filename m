Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1736C27E60
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfEWNmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 09:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbfEWNmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:42:38 -0400
Received: from [192.168.0.101] (unknown [58.212.135.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B88520881;
        Thu, 23 May 2019 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558618957;
        bh=RUb9icmu0Ty8LfzEJ902RXv2qHZxk/BhEuHdhN79j/A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nPGcmaQy7OSDI6cW5QhnextVgb6tb6qXHw6AE/nE1ZBisUrN83Cl4bD7MHvXqK6mX
         q+ucE6i2ZHaq2EV8t4sv8zFN/oZGl7CquyP2D6bTZv0es+KXndN8hWdpVxi9+WdTIM
         btYBcH+BSc+82zNOU98UJTa6+Bm/moo+6M23JKAQ=
Subject: Re: [f2fs-dev] [PATCH] f2fs: add error prints for debugging mount
 failure
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org
References: <1558585157-9349-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <079b434f-ee28-2c52-a789-6116e20ccce6@kernel.org>
Date:   Thu, 23 May 2019 21:42:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558585157-9349-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-5-23 12:19, Sahitya Tummala wrote:
> Add error prints to get more details on the mount failure.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

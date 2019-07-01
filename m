Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5634C82
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfFDPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 11:43:32 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:43439 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfFDPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:43:32 -0400
Received: by mail-pg1-f173.google.com with SMTP id f25so10578961pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1tqQUYkCiTPuRzyCy9UBEdirWqMAznB0ETrGx/j7ot8=;
        b=M998QStZ8hrJ2FjhCVVSwN4KLJOgz73IXrSf06GwSHt2Kcyb8QwopbYLocRJJn8Qna
         9aoKrKIr+IW0SGQkkLodklP545PgTzJxSr+KqJok3jhl9FZyPtLFpnVr6oTSg/Iy1IFv
         DCfmBZzmwGb70dSfOxZ04RZQfecnq1skXX2/fjkv/J1WTJQWZCTSGkmY9LtQJoGBvyD2
         KB4YUr/Y3kg1wVLYNmcI9f16MnhS9TzjSFehLMAdTUsFM836NLGXci80US8XQ1yxMzbQ
         tOeOd8a2kGtBHuMrCKEyQIIpNZ659MrOaooDKXkFMJgyeOgq1Nj6DxUSmWmY7LnW6aXi
         q73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1tqQUYkCiTPuRzyCy9UBEdirWqMAznB0ETrGx/j7ot8=;
        b=g05YgTqzQYj05jUJSVKMcmv3YRSOOBp/74Jt1n+iKhoX8QBpmU7tg6OH78HvKLl7mt
         lDg5VXciS+ciy00zN5UmXCzzL0RxQ195bHvpB/niGpLVWNnyaGec9/1zwPssNBvLnkx6
         XyDzZkL55XhDFdqRmF7czPSN6udfzS00kT7bhN3bezIOrEaTccu9QZgPJLLaDIw+3rqU
         DzwOdohaWdhg+CTb6ZjFJM6ZXcd+/DmC/+QKm2fjhH0UO4nKgrsPab5oS0/Ai4OF6uxz
         jw3Q54xVINAIQKdgozp76jCz6CuoNMETzHFrbbnL5uEXY+lHP1EA/ftxc+DfJAum4yTn
         JlEQ==
X-Gm-Message-State: APjAAAWSVIJvmkhDkwljO28YEp+y1Khhv3GnKDBb3x3yxv81tZJQFMlQ
        KpLuTddzSf93DGjhuA8CswyAlYrCcN4LvQ==
X-Google-Smtp-Source: APXvYqw+0N0zrwtySyXMlKkP0zfzYI5m7MA0xh3RMk9nK5rSOHW7riQreacg0ndGgXI3TCzaBMFfRA==
X-Received: by 2002:a62:63c6:: with SMTP id x189mr26994829pfb.31.1559663011107;
        Tue, 04 Jun 2019 08:43:31 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r64sm25606402pfr.58.2019.06.04.08.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 08:43:30 -0700 (PDT)
Subject: Re: [PATCH][next] blktrace: remove redundant assignment to ret
To:     Colin King <colin.king@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190604142744.15330-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f834f32d-ab6e-c429-1a3e-13512583ee08@kernel.dk>
Date:   Tue, 4 Jun 2019 09:43:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604142744.15330-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 8:27 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable ret is being assigned a value that is never read, hence
> the assignment is redundant and can be removed.

This doesn't look correct to me, here's the full code:

	ret = -ENOENT;

	dir = debugfs_lookup(buts->name, blk_debugfs_root);
	if (!dir)
		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
	if (!dir)
		goto err;
	[...]
err:
	[...]
	return ret;

The main issue here, to me, looks like we're not dealing with ERR_PTR
returns from debugfs_create_dir(), just checking for NULL.

-- 
Jens Axboe


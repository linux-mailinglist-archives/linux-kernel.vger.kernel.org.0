Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E2131E33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 05:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgAGEAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 23:00:52 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51994 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgAGEAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 23:00:52 -0500
Received: by mail-pj1-f66.google.com with SMTP id j11so8427115pjs.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 20:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IDCrh5LU02xdyVVSeGrhk0v+Nn+rcCBZJkM7RND9gQc=;
        b=AgSB2QGcNOkAmQDnPg0qJ95jZuF+cox/xKD8BbOZPNirA5QsJ2qABy6jsOHbmFe86x
         feKPo1pAzo5sNCeduh1hwtHtLlqlI3KqiQfI3X84uB/ZdCymQ6/jKqDhDOp5ISFzwUeU
         W0Zc5STk1TY4RG2xQ9M5kW1GwIsoPNDDz/J2F3xef2CoXrLGRzWMQXat7Y15YLT8Gzrx
         O08dvSkjnrUFYr3OdkVNFRuoR6xo4U447jP2K6R3irf8dkurnhJmkvLOwHfvzIgwpCQ3
         0VtuhTtLDYytE0lzl3RnNoRJjtq1/L5aBFyxl25W+9mpkBt0tg3q8Z6wd8QenQmAWOpB
         nvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDCrh5LU02xdyVVSeGrhk0v+Nn+rcCBZJkM7RND9gQc=;
        b=kECaaSstuldLxUtXfDjxRxrg412xegDdSbJmO+kf4S5omA9g7+qU4d9i1HB8xmjtgg
         OZRtP2SFwBKws/WtSuDoJkgR7WcbpAV7XKef/mikYfhNxX+fQdC2wpvu1RDLC0nz5V+P
         5e96faWLjke16/EuWyh215tXRxMtz3HyyQuzB0XSVUQX02sNi1a5B0JBrGbpP0G5KnD4
         LNsaVvQ/BOUiK97ddXpDmEbt2SfweAZdteXORrMjGTNj1k+F+2Mv3bwsaqT1qY07zq7U
         lLdej/G/Tf66UAYrzqWBv5dvQ19rdTerPVZZ1c/ACvGp5TaIg12mkyU8qa48if543Oj2
         K50Q==
X-Gm-Message-State: APjAAAUqp9wJMcEluYbmrAGJ6xgNt9JQlHwgs1jf5IgRCl6KgTh4TzaF
        1tr0MaHJO2BCBB1vgBbI83x3wA==
X-Google-Smtp-Source: APXvYqxXapE4v1DYtCz23M9HSUSd41DR55c5Hx3bHbCFrSt8T1CTv9+m5BUMjHoBcbR81AGcHP0z0A==
X-Received: by 2002:a17:902:a407:: with SMTP id p7mr103951146plq.4.1578369651826;
        Mon, 06 Jan 2020 20:00:51 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z22sm73051202pfr.83.2020.01.06.20.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 20:00:51 -0800 (PST)
Subject: Re: [RESEND PATCH v3] blk-mq: Document functions for sending request
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20200106180818.85365-1-andrealmeid@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ff62e36-b285-3fcd-be2e-fece1ddcb0cb@kernel.dk>
Date:   Mon, 6 Jan 2020 21:00:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106180818.85365-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/20 11:08 AM, André Almeida wrote:
> Add or improve documentation for function regarding creating and sending
> IO requests to the hardware.

Applied, thanks.

-- 
Jens Axboe


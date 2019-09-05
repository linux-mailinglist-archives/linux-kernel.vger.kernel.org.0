Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B177AACB4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbfIEUFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 16:05:48 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:51362 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfIEUFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:05:48 -0400
Received: by mail-wm1-f51.google.com with SMTP id k1so4172093wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 13:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u7j6bRp6tgNAxHJKMuhoBeblo7uaqvEtq73jUP1ye78=;
        b=gASahD/1KxtxUpvS/okKWD3KVkxcoxCwn3YWgCMItWQjcdNjhp171FpY+F2Pd/D7uo
         YqAkQ1LQ/FEeOtW6QBwQDSPKiYHkVhBz1qbc6IQFIYhz2c/6xBitR4SJVyUSt7zG5TBM
         nzxDPykOdrWpTEvZowNNuzEEdoCw+K1y15j1DOu3P6D4X2gI4/VUzCgUuGCMqqyT+sGm
         C8exg/DxY/uMI0I3qvL+bslJQuVplwUKcHJ1+qQwMtRHSJCOA9ZGp4fnZbSKwYQA16KI
         labmAHLKf2TFhFTQb+H0MtyC5POdJ3cuTRFeopN9yj0GcU4X6tCsBRdT6eGJ1YZ6Ak49
         iOGw==
X-Gm-Message-State: APjAAAUwQ7uJ1+eWzRn5KRmMi9zFhYLMmdP2xZgIslAD1XlmG1ZQZ8kC
        jHGnrWl5cOL6mHAxVUWtdhg=
X-Google-Smtp-Source: APXvYqwl4RwjiRyawN+y0OPGL+qW2tlPnNBWfsrd8ZA6SuH6V0ry+V4h28ZET6fPiFdUc1gXT1PMbw==
X-Received: by 2002:a05:600c:24cb:: with SMTP id 11mr4269994wmu.94.1567713946456;
        Thu, 05 Sep 2019 13:05:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id m62sm5168268wmm.35.2019.09.05.13.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 13:05:45 -0700 (PDT)
Subject: Re: [PATCHv2] nvme: Assign subsy instance from first ctrl
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>
References: <20190905163354.25139-1-kbusch@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b47de61c-c61e-359b-416e-28d8db0813f8@grimberg.me>
Date:   Thu, 5 Sep 2019 13:05:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905163354.25139-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Applied to nvme-5.4

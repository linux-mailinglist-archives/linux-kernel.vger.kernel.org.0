Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48B170C68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 00:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBZXNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 18:13:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40555 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgBZXNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:13:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id a142so1349492oii.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LM7pNY65/Ack5oM3mhOihMwCzx2wt+oOTbe6BoaJpYqw3XhDXJky513WFETKxO3Qhg
         HqGR/gqwBfBRANt/ihcgxpmefnd7AKlrhQjZw0c0iLv7t2HlO+N+gWW7HVE9v1yG+av/
         2r9bnVpYQ8dRQ+tdb+2K2LByxJBJU1ADXK4RtKfdZvPO83+T5g/yaIAfuYSxX5f1Yo+c
         hjFRsKJGl1dWW+edpj9tHmu7xSllaX9WEE2cuQZ7jkUQiJFU0KolEgde37+mKhMqflvg
         m7wfID42YvwK+CCDvrZOLcGfi290DwZGUeCgXHXmFC/Si3d34mSqDg2jkMm1PHDPPLTL
         ElpQ==
X-Gm-Message-State: APjAAAXTqHPzC91z4SzpEWuQ4ae/6kclgEnRqWiywQ7c7RtuRE3n+Odd
        VM1UFshJNYSRxdab+mNqWyaCJ4az
X-Google-Smtp-Source: APXvYqwAxbREtJds6jbJUTGmza2mEVUDWAADxyu2wuggfpc+mCxSvPWaw2UY3vgPNcJpSCyotDZH7g==
X-Received: by 2002:aca:b703:: with SMTP id h3mr1155393oif.148.1582758832520;
        Wed, 26 Feb 2020 15:13:52 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id r26sm268099otc.66.2020.02.26.15.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:13:51 -0800 (PST)
Subject: Re: [PATCH v11 6/9] nvme: Export existing nvme core functions
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-7-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ae8b6be5-92d9-f6f0-6240-d395aada10b0@grimberg.me>
Date:   Wed, 26 Feb 2020 15:13:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

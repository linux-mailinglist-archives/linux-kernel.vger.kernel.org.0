Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C827366A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 20:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfGXSP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 14:15:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45374 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfGXSP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:15:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so21606030pgp.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bXwizhsA3Py0+Ja6AQUWXO9ZkFxvTTtHH4GUUaQRVaqiifwaGTQ+EJy037ik5mxGUB
         xuc30q3iZXwSs9qShr16jIDRmx9C15OcQZQjozvobFnjEk8EbcF7JxJ20S/SunzJxmmZ
         /CwaUYVrUd31hyCzmJ7MAhlGnT0JMPQEKTCaHkmmYz3qBkvlx0DwQjOYV9asxnmpYFSY
         YTeZ0QtXLjrWvlwIS8V/hMvXpR5jbGlOUGL+286fQd6YsLa487ZU59mzC1TNt+2l11o/
         byjMCO2bQXL+9hwx7v+7vBNt7Of3ClMJZ3KambRBfNSSTcZUSymS51TDFMvwr5ytdSg+
         KPeA==
X-Gm-Message-State: APjAAAUcXKgWqHBU1bBO7Es7KqetvFK9vllH+/dVj2NfqIomQ+qzfqjt
        RzVpttxLMFcQnKE4+JAaLTlcj7OO
X-Google-Smtp-Source: APXvYqwoQK0l8fYv0g/LBeIpzqI24SeQ0oFFCUiWgxMTWtvP715mzMIAeLfgxfRDAzSCuVJCyOjGbA==
X-Received: by 2002:a17:90a:ca11:: with SMTP id x17mr89616329pjt.107.1563992155401;
        Wed, 24 Jul 2019 11:15:55 -0700 (PDT)
Received: from [10.8.0.6] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id i126sm51835074pfb.32.2019.07.24.11.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 11:15:54 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: Use dev_get_drvdata where possible
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190724122235.21639-1-hslester96@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <451e976a-fc48-312d-eee3-6f4b2a53f4c2@grimberg.me>
Date:   Wed, 24 Jul 2019 11:15:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724122235.21639-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

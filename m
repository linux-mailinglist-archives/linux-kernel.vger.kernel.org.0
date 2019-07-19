Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E096D791
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 02:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfGSADx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 20:03:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46236 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSADw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:03:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so22923970oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LfqsH9Dy5EI0smB3cwAtmZOU+arsDaPcv42+Ozh309pvwEFLDwTIE82BQT9grvBZAD
         BieAl0c/5EWZ7gLAc63OOAo++Ag6VIIugoW8DB/TlXlf8u8jgoT8FFOcBthuUl4dy4d/
         AEMhVdOiyTOm/41b6C/t5bglXwv78BaIZfFVKPnJrdEz/m45gvYreByZOUJ5v3cVGRZB
         JtX3cChzB4oHNrgGb1PtX/nRuvNxlVv9qOfuK2IMmOHtFsNbARY6tGD0K+dOW7jtPyr4
         1Yls0MI5PJBGmIPwwkuXP0fatyDS8/G9/Jq6Ny7fGtNFUVWjYowGONl+TJd9iC4nobWL
         dODQ==
X-Gm-Message-State: APjAAAWNsvLvSz8mWf6vOpur0U3jw2/V2evuvWcdtYHg0kBI2cOidN1p
        dhdNj1m0t12qv0zT3wYBbNY=
X-Google-Smtp-Source: APXvYqwXmI+xmNjIVWk7h/9AC53PT7Gf6EJvpvJRB5XNz6gVL0e+il79g7iVNW+3cnS9GFhvUFmcjg==
X-Received: by 2002:aca:90c:: with SMTP id 12mr23595245oij.91.1563494632110;
        Thu, 18 Jul 2019 17:03:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id c66sm9632510oia.58.2019.07.18.17.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 17:03:51 -0700 (PDT)
Subject: Re: [PATCH] nvme-core: Fix memory leak caused by incorrect subsystem
 free
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190718235350.6610-1-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cc96d8a4-d5f7-d445-ed26-8e9326b050fe@grimberg.me>
Date:   Thu, 18 Jul 2019 17:03:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718235350.6610-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E07E21F75
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 23:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfEQVQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 17:16:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46844 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfEQVQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:16:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id t187so3835137pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8C7aPoXHexIfrlHhYHRVmdZ+RVtChiwK/FINI72oIIk=;
        b=yTfmkBZBWvUi2ekNTMUEu3+WBCpg8N2iG2HE1lr+hM6WmMtEBoX+1ancJFh8m9ySnM
         Bj+IV+oPizUVMFsqawcvDremAnWREzKR0w4fZ90UGMvEZLKrpG+6MBLgFtYWop31KZNZ
         suGTvhwQa5shw0t83QcF5qhwXBQd1ih2vANaBH5b3MfmJVQ5YyyZFHgHgDf4KGlfLVVC
         WeKXH2SFJPJpwXy+ZOFDE+8oZZ35E0tfgy+hsAo859Vnrk1jd7LfUZPndKXSdQvgouaZ
         2DVZaxcRhz5KE9d2pAmYW+OPyZNb/wQ/kj+LsQvKcIFTZHB1gseLIIYCNh0Kcc+3huvR
         psmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8C7aPoXHexIfrlHhYHRVmdZ+RVtChiwK/FINI72oIIk=;
        b=gmOmrtzE0JnY5bTiKULItNxhKb15qhfd9IEySpHbm6jvzyISD8hdsDkv/MKQ+aRqYy
         x3vZUTDGo4gXU27soE7Uuxirp3JQWrjOfZRkaStDxiFVrhXp2cfrZ/sdRV5QHllZNaxE
         vzZn92pA78VnGjzo91l2DZTGdLvY5rClg8/Dj8vVvGrwg2Whu2YTGAdZ0cKT6vHbhfXK
         fOetkdTqPX7kF2C5WQ1VVNjqaiBXD/SrcPrBlJ5RoF+zX1uZfQPJnU9dz62c1Fuy67dk
         ij2Nyeaw0NjSndLT5IdRhpoh7G58iqhXLJNIPrTFsOJ3QPtEfJZcc/GNS9KuyxOuukw6
         8Kkw==
X-Gm-Message-State: APjAAAW/9QWBAI/OYDIPw/M8yDpgg3BZU73wTCnRTGCo4ZSBcs8M7jwD
        6Ns8XHiov0iA7h+x5gIzBmNGn5iRggezOw==
X-Google-Smtp-Source: APXvYqzPRMxc3nKwzJh/NcOxueLogSIrrgwJZb/Sil8TltEjbTO3m3nKFnsuWTjAizapueDOZBohnw==
X-Received: by 2002:a63:a449:: with SMTP id c9mr23257280pgp.149.1558127791244;
        Fri, 17 May 2019 14:16:31 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id w189sm11649008pfw.147.2019.05.17.14.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:16:29 -0700 (PDT)
Subject: Re: [PATCH] aoe: list new maintainer for aoe driver
To:     Ed Cashin <ed.cashin@acm.org>
Cc:     Justin Sanders <justin@coraid.com>, linux-kernel@vger.kernel.org
References: <1558125894.9571@cat.he.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <856ae195-ceb8-5657-5ce7-9743f96845a5@kernel.dk>
Date:   Fri, 17 May 2019 15:16:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558125894.9571@cat.he.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/19 2:29 PM, Ed Cashin wrote:
> Justin Sanders, who has extensive experience with ATA over Ethernet
> in general and AoE SCSI and block-device drivers in particular, is
> ready to take on the role of aoe maintainer.  The driver needs a more
> active maintainer.

Applied, thanks - and good luck to Justin.

-- 
Jens Axboe


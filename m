Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7DF1831DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 14:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgCLNoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 09:44:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40953 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:44:54 -0400
Received: by mail-io1-f68.google.com with SMTP id d8so5695104ion.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jSod36pOWDs7X6aIKTPYmJy2lYb5ks2I2R+9h0FGWFU=;
        b=0+qXPbtGwDNE2YoNE0/9VIQd8MBavMQgoIxqFLu3EY73F2R3ZlDW7Gd3co7LH0Ul1a
         G+NbPTk12xnDTBtWv8RvV13XG61ItjUpzps9ExMctG060ZIss78OP2m2PNU4PLUJI8IM
         FHY36kGwS586lRSR9BCxgZbEpkYDxCZFbmfrLcCbPjR9c6m87/ft2eVyqEy+9v4mAYkw
         pv0qFd3LE9AlAIkcSoPczCGDeGvI4dL4D3o1plsYgrSMeezl+uFeMID2zw1eE6174Plp
         gbNNSpq/DYxQ7AzFFNUIMBgBSIrPyVeOadoCU/SAvR7dS51stOKlgMGaBKuQ1MUk7of6
         WugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jSod36pOWDs7X6aIKTPYmJy2lYb5ks2I2R+9h0FGWFU=;
        b=t6OLFuegC0q5Mh5NMIW7j9BYrnjYi2NwxXLtI1OOMG7SAX8PcWdikNQ7z4UUcrKowP
         dW0SbyDkfxH59VI6vkmF7uS86Ewm9wX69BNCHDALz8r2em/9SsB1dDiMoRkKblGx1hP5
         pK46HfC0Q3/mAzTn9lwDGyj+sbEiBTi1S5Z4zEcYs/C6puy1HBojveDuEWCy2QitiWQd
         FIL1rGx9PCMO6SawWNF3WESR6bxJgDyjVt1oVtV/nwEFLN9dKo9n+QNiPC/9zFWjO3gI
         xR8K+RJxaokl13yawGC/aJBIpQYQg65oifReYsagzdepYoA5KfQgMedhA2BD5H1y1RpK
         Hk5g==
X-Gm-Message-State: ANhLgQ2spHKGieMLBVXjjUZ6bqv01Gyr11qEXaojrUIe/KHVXZybqabJ
        WEiba1cf5+AANCzhoUqFCk7WsA==
X-Google-Smtp-Source: ADFU+vtkdkvvhK1Qd+AjLgeTPV6ydTaQgxfR/zxzfvz+3djEa3i9d5g8qDxKTYrXRZCJwr4GdUbzVw==
X-Received: by 2002:a02:3f4c:: with SMTP id c12mr1230937jaf.115.1584020693065;
        Thu, 12 Mar 2020 06:44:53 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q6sm5341596ild.70.2020.03.12.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:44:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] AHCI: Add support for Loongson 7A1000 SATA controller
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <1583844608-30029-1-git-send-email-yangtiezhu@loongson.cn>
 <1583844608-30029-2-git-send-email-yangtiezhu@loongson.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <12315c32-4e97-8d05-2dff-709fad3b0d38@kernel.dk>
Date:   Thu, 12 Mar 2020 07:44:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583844608-30029-2-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/20 6:50 AM, Tiezhu Yang wrote:
> Loongson 7A1000 SATA controller uses BAR0 as the base address register.

Applied with the pci vendor addition for 5.7, thanks.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDC31245D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 23:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEBVyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 17:54:33 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:46989 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfEBVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:54:32 -0400
Received: by mail-pg1-f177.google.com with SMTP id n2so1650159pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MBID6pBuuXLp9VD3vm7yEVW/E0fVBtd0jBdpqdXVLC0=;
        b=gfokrAicLKNGer/uo0EkviXH3nnCofvHPG9FIRrkF+5Oj1bmdkbcVVSCHjnMHpgZnF
         hz0+cKKKbq/QQ/3QzXgJzXwuaG/2OYo6YkMmmux7LNzf4EOC/7KJWtk7bMVALPcU2siP
         txZddaANjlieQT9vDwmH1OvOubliJMluG5kA4QSLwO6x+OwUh0BPOSck0hELCBmzu0GE
         WiI29FelhNMxankj023zpy6B+FRkeSOX+ZPtIvqT1Y0dpleXm9KpKhiG0VrqmEY3/mWF
         Q6KZkYTS24ShbIkZtYK4S59Ia1AV+5jfClKGAP5BEX4ngu2uNFhFQdpUrj2C3aLJrEy+
         AJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MBID6pBuuXLp9VD3vm7yEVW/E0fVBtd0jBdpqdXVLC0=;
        b=dyU0Wul6+ZNZWxH4tn9H9l9y7ENwge65g0IRhXGdDmoVJw0WnKcZR4ewdQtyxDSbvL
         CgtaDyiIBjxq1zxA7Pv3NOzxWEEcVggYxBwojHojYfviyYzDgTtslM5jyzprZQ4TI2gc
         27lDwBl1WMqtiQsPrTKoU4FUVmTId/lXjkWkmObsrmcO1r6srP89CFd5uuEIsF4b57R3
         ne03a2ZXMFOZdaIUVvzjX2ZT0axFUyn/iQjN+K9B/yI7D3N8Wzqbrl4SSGAnUgmTXubk
         l2HyJQxZ2J/nZfZX9aHrU+jJ+NI8uU00QGzNCLi6p+PNWzZJ4OZLGopRv/3yXVY4meJK
         kXPw==
X-Gm-Message-State: APjAAAWvD7sVePleMYv/BXou3MdCsk6ikjXN6PbGml1u1SqMh3mGX375
        4dmrvkRxIVnmm0BRgTUe492/wv3VWZTayA==
X-Google-Smtp-Source: APXvYqyhV1eEt6chsop8uJjOJ+wfqlGOQH4zCm2/kWX1Rwv0owrFJMOClqEdxV67K+VYlA5QFhd1RA==
X-Received: by 2002:a63:7c6:: with SMTP id 189mr6257276pgh.247.1556834071704;
        Thu, 02 May 2019 14:54:31 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z9sm239392pga.92.2019.05.02.14.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 14:54:30 -0700 (PDT)
Subject: Re: [PATCH] block: Fix function name in comment
To:     Raul E Rangel <rrangel@chromium.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190502194811.200677-1-rrangel@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c620d95-0194-eaf1-f492-62716e188efd@kernel.dk>
Date:   Thu, 2 May 2019 15:54:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502194811.200677-1-rrangel@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/19 1:48 PM, Raul E Rangel wrote:
> The comment was out of date.

Applied, thanks.

-- 
Jens Axboe


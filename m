Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96F8192E15
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 17:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgCYQVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 12:21:13 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:37992 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgCYQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:21:13 -0400
Received: by mail-pl1-f177.google.com with SMTP id w3so985501plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9w7AiaZ0I1Kr1hFPHxWeGuVfiO+BvfqSfTlRt8g9SjY=;
        b=WHNqffGZhqk8UR+uLFGk50QXSaMCvhjuqIe5K5NhimUpbSLu0Luo1Sfe7HvKR66Ic5
         C5YDEWi6Vq2i+hSpJ6145Hrh+nvPpJe9ZL34aAUfYLP1d5Nh72vlEpIw83p/rWaywRya
         YMIGawflr/hBBD/GeyMFWAB9ERAcGww5UpEqyMjOj58Jz/cEY2lkiQrX42pPev50fEQz
         fli1YEs147V8ZyN203Jv/8DZye68DGpccX3eQpmoe8Vk2IEIqf5EuQVVF1Y2qx5IqXog
         TmIn34JRgGU+jHyAPlCzFIYyIu26dGmbf0ZRIzE1KLWt/5srIdVyONtLFqAZoWOAbuq7
         9NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9w7AiaZ0I1Kr1hFPHxWeGuVfiO+BvfqSfTlRt8g9SjY=;
        b=ueS5mBFC/dvaEAhGXCrt1/UaLGks1vbVkQOGq3uIMBgL/dDk8jv8V4EIuDyfi1tNdn
         5UxOpSrnW+0RAbZyWnF92sh85ZgwUVb4LvTrwpdl2ygMblWonWpgWOnLQy7+ahR/L+yw
         /2NHQlGkAGJAUwe0YXjMmrlO3gFCX0OCDpWNvLRzNrJ/iYT6wM5v9vJAgtGZLEa0YIXw
         KGyMv+BdG0/mTcUjyto1LXHXvRmNaJSNfCQFUE0RVHhX5vSKwqupmFieQVHMzDofZO/6
         pLGtq8Yp0hSMt5DWvuTj/ZOykVDMctlPNFlN6ZRNOMcSk5HRUKowRCFhbbUKWciQD7rh
         O3MQ==
X-Gm-Message-State: ANhLgQ38qbSjVCmqj//4JBF/5PUCCsF1ccC6NhN1iYhxoEjdQ7fb+z+S
        Idz2qrxs69V80H+/agTVl9a+P85fSLxeyQ==
X-Google-Smtp-Source: ADFU+vuiKPochloItwc/nZUksJU3th/kYXuHqdmzB8RotXh71Ew1ry1CxHJl9LOqDTxqGjOiirpJuA==
X-Received: by 2002:a17:90a:930e:: with SMTP id p14mr4534381pjo.159.1585153271543;
        Wed, 25 Mar 2020 09:21:11 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id m11sm4816006pjl.18.2020.03.25.09.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 09:21:10 -0700 (PDT)
Subject: Re: decruft genhd.h v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200325154843.1349040-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab5d4f34-40d3-44c5-10f1-37841cc7e5be@kernel.dk>
Date:   Wed, 25 Mar 2020 10:21:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325154843.1349040-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 9:48 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series tries to move as much out of genhd.h that doesn't really
> belong there.
> 
> Changes since v1:
>  - rebased to the latest block tree

Applied, thanks.

-- 
Jens Axboe


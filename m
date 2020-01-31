Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9014EFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 16:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgAaPlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 10:41:52 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42258 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgAaPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:41:52 -0500
Received: by mail-il1-f194.google.com with SMTP id x2so6490404ila.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 07:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bt/QheAZ930twwioViVJw8WXYDgWI7UHXp6ZgLfEFvU=;
        b=A6Y2AxBNtVwdIYHMVc3HVU8q/VzulMbzj/3/CIXAT1NEl9g+rtYxLOZL0iajhtIH2h
         MiLriuEA35OxvITi1H1wcLnMy7zEM42kjWp+nV44p6Hs6yBhBUfYF+CthIJYAayJ+nuX
         KCQQixMqG90XFFpLWL+nGFGJg9T506YOP0lJW6PDhMwqcDTVKct76WRd6XFLaMwx9Bkn
         uEPZ5feqGTRx9pGjZYNwqYBDDal5sa/0x7x1nfjPOy+8A/wZoVtP/FpcAUGoMrx6NeH8
         OxL2xDbd8/HQGw316yFtDyGmr6CYXUjoHNSbCIXsqxQx0jR0aDHoNuccm35OKtmQ3Fpg
         eIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bt/QheAZ930twwioViVJw8WXYDgWI7UHXp6ZgLfEFvU=;
        b=nx7PKO2ry04sRm3wInvovQG5qkHSkzLTgnK9/aBvuMWYUZuYAm5xh8E3ec+o9OXyGs
         ER7pNbVSJXH8zZVqxrpcN2VXW10HQHFvxbXE5BmZ7LQQbum+yCBdU8p1PFzJqS5tKlI6
         nfBFSGd+kwymf3CeQh+9AJqn+v1QXdeY+/FugBWuboWQ5tRwzDiB2jGWv+f7HNlOMROq
         T2YAGcLg88Rup06bFpSCoo23ej6vqzN68GzXUUiyzIQBBpgYsNwCynDyg4pvnp4iZ665
         N9hMipKn7S50XcTRfUbJiURUzF8+ghszVg8VltQBZcwpAZQECOgiE0Vr+FxRM5nNMSn4
         cH5w==
X-Gm-Message-State: APjAAAWEmnav9rZg5Ra7xEaUgbv8wc007mc2SMv6WsxXBsOTABQBKkpA
        +27p0fjHA/B64J1UPDzPsQ3O8A==
X-Google-Smtp-Source: APXvYqzmFO+FwGR8L2EL82Fy4qUmOkX9hKN8xdZIQNl3E/nj/xI2hVeg29FnzUN/wjKuFPY47A0oeQ==
X-Received: by 2002:a05:6e02:4cc:: with SMTP id f12mr3138757ils.90.1580485310666;
        Fri, 31 Jan 2020 07:41:50 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s88sm3276032ilk.79.2020.01.31.07.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 07:41:50 -0800 (PST)
Subject: Re: [PATCH liburing v2 1/1] test: add epoll test case
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20200131142943.120459-1-sgarzare@redhat.com>
 <20200131142943.120459-2-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <00610b2b-2110-36c2-d6ce-85599e46013f@kernel.dk>
Date:   Fri, 31 Jan 2020 08:41:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131142943.120459-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/20 7:29 AM, Stefano Garzarella wrote:
> This patch add the epoll test case that has four sub-tests:
> - test_epoll
> - test_epoll_sqpoll
> - test_epoll_nodrop
> - test_epoll_sqpoll_nodrop

Since we have EPOLL_CTL now, any chance you could also include
a test case that uses that instead of epoll_ctl()?

-- 
Jens Axboe


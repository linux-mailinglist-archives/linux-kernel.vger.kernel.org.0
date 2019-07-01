Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF32AA66
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfEZPZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 11:25:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36858 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEZPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 11:25:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id u22so786041pfm.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aZIYcTZb49nLbN4UbdL20Sk9v3C/xflMGyTZxH5wCk8=;
        b=UmS45A4XmHzsBrF5XzvjN7YRvRJkXkEMy6lEi+0jjpMdbuDSj5z1PG72DHfPmlVzPr
         TAceCEqACAJk+wGxtpfZ8o204qebabOxOEIPjsmqu3DCvXINoxO8k/Nr30dMzhkD8Rzc
         CbpYLnS4c821E6J9Q7cxYXFNgXzRoML84omD7e/sZY2XhrWWgIG91qRARUlt5HQqdFps
         GeALwFl6PkpCYSvwmESdIAiJoav+M/VpZKmkAjMyPvw/Ehx+jeRJtx4I0/a8iVHvuW0R
         JXWJi+bePJoOGbfyrCTfzlfgZQWB0v6EoC9ORe0y05otJlwK1Ys+G+uPGTtEhFzkzu9R
         8C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZIYcTZb49nLbN4UbdL20Sk9v3C/xflMGyTZxH5wCk8=;
        b=tBr/EQdix+9cQBTsgJLliYUvOIerrOEtG8in6Ciu3CErUoCHME4gV8Eu3OS95qrhqk
         pd5M/wFmYMMVtyKPkXWCHQN0v623PNffx1ieqdYC+LVb4QR4XYsKVNxfJXzvQ5pr0dcm
         8ycFolsKnkzSncKFTpzPnEPiRmo0yWbp5PhOZnKNszQ9P5ojjJJyyFDlvIPI1KUAn2xK
         7qb+ooqejV6rTVgQNqrKgtzafnixJoSy47a/iVYjRKjAeykC4f1Wu3Vn+qj/NmzXVc+p
         IatANkQZ+wlGj23cNSOJT73ItH1Vc/Kk2j5XRKjFIzvV04TN5zAWwa0t0Tq4wP5xEqer
         yQyw==
X-Gm-Message-State: APjAAAU5kZBGeuDXxCOvRcAhvnoS/z+joQ7hdVm+hi3D4/r/xqM/pAhu
        tucjTJLbSptXhiJk55bSdFmuoUnZVsdEvw==
X-Google-Smtp-Source: APXvYqyzbIPRRr1xDnDYuHHhxapcwsR/49J4utmIw8/unCWstSF4sDUXprbl7ZI3PIJ55C19ERkKiA==
X-Received: by 2002:a62:4d03:: with SMTP id a3mr131986235pfb.2.1558884327722;
        Sun, 26 May 2019 08:25:27 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id j7sm8743596pjb.26.2019.05.26.08.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 08:25:25 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: Fix __io_uring_register() false success
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f9e0372fd0e52ca276bb307da1271908cab4efb4.1558862678.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0bfeca3e-2485-3679-a3df-10bb22237fb5@kernel.dk>
Date:   Sun, 26 May 2019 09:25:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f9e0372fd0e52ca276bb307da1271908cab4efb4.1558862678.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/19 3:35 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> If io_copy_iov() fails, it will break the loop and report success,
> albeit partially completed operation.

Thanks, applied.

-- 
Jens Axboe


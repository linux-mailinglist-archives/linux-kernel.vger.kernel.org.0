Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C0C676B2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 01:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfGLXDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 19:03:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfGLXDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:03:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so10231011wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
        b=V/tOHjziBsgD5AvjoifgPMYzgqIiVssswLTCnhAqpc0DNS4N2mcTbZWUPQR3rXoRbn
         AgtpOP1p+tr8k4SdfPCzPXmX7Tz/I9YNyPrnyVIz2oKOYmWsf0IGDTVFFT8LK+NBBDbw
         eWou8i5MbFmtPxsdwnsrlg8cqPD2WAca/Y3SyPcFKYFvx8vpyFSS+Xi/tQdVzwYYQqtF
         2SuaVZ7rr6WWoqs2EsyV9GmtZ+k65uiH5kAy5xW8bfGtgI9491mon7LgIVP5vsitxili
         CvAKUSRjrua+UwDhkNv4TYYvVw7+/yV7xe09g/mUg2r/2O7GV+ZPGBFBhMIyXzlAAae7
         1rPg==
X-Gm-Message-State: APjAAAXkO0ukoyIPEVdVXysh9wIEvSrW4s2PWOFpvMDIFmpue4CLFvWs
        6/FJDOb2mx49zgc1spRso0E=
X-Google-Smtp-Source: APXvYqyQ2j/MiBFp3jdmRvJk1mKR8bT7wcUq/MudGxsYRpb0bK9Fp6aU/Kh9BT3tyhnenfSc9KauZQ==
X-Received: by 2002:a1c:3c04:: with SMTP id j4mr10683379wma.37.1562972630153;
        Fri, 12 Jul 2019 16:03:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a6sm7203765wmj.15.2019.07.12.16.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 16:03:49 -0700 (PDT)
Subject: Re: [PATCH] nvmet-file: fix nvmet_file_flush() always returning an
 error
To:     Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20190712224207.22061-1-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1850b155-791f-159e-4e6f-683574d8a9ee@grimberg.me>
Date:   Fri, 12 Jul 2019 16:03:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712224207.22061-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

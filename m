Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3182AA809
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 18:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfIEQMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 12:12:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35754 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfIEQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:12:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id 100so2772514otn.2;
        Thu, 05 Sep 2019 09:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9/mVvbc+FJD5lFAC39ToEnsu4tlFlkzdP2wms0HhJ0=;
        b=onWw6K0qzayij/5pbblJ4nS4cT8GAekxkmlqWH+GC9tldwKaQzI05hkGxYOj120pR3
         h7wtWPa3CpxfL3J1/uFjC4m1WhMjqiV9MS76HHYE7hwx9dcyEuLhN/cTi2LVWhqF5wVf
         t/b5rd3hDbEa30k//cIen12m3qvWabSRntTGpr3b5MNKS6g6bUbwTclXu1uPeKYPqROJ
         Lk2EQi06wkKRVEIOyZ80qJGv4dZhqZ+d7pIUPAEbCdjyZNA3Ybd6RwVsCyyxwuHHqQME
         UTErUJhsmb1sRoNtmFz/SRoPOErdZQU20dJkzWDZfoND6GSTmZTGDhPlrVGxYlQP3vTb
         OhKA==
X-Gm-Message-State: APjAAAXo3m1cxVtgGK3zjFRXZfv015rc9CDz0sscOvIU5IOCBYX5S/pl
        c2ovH3dskn2PGqvclb4g5ODZNtVl
X-Google-Smtp-Source: APXvYqzRcb8W/oZq18yF/qsn+UkujlrvsEZn46ppLsm0+TIemu1nunO3GijvRMpn59nJIjSofzxQZg==
X-Received: by 2002:a9d:7a83:: with SMTP id l3mr2122370otn.359.1567699960205;
        Thu, 05 Sep 2019 09:12:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 5sm595489ois.15.2019.09.05.09.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 09:12:39 -0700 (PDT)
Subject: Re: [PATCH] nvme: tcp: remove redundant assignment to variable ret
To:     Colin King <colin.king@canonical.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190905143435.2864-1-colin.king@canonical.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2aa4f13f-7d24-ee59-ac6b-ed3dc30d3da3@grimberg.me>
Date:   Thu, 5 Sep 2019 09:12:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905143435.2864-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to nvme-5.4

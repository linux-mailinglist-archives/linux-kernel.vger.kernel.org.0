Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5D1F782C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 16:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKKP6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 10:58:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39800 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKKP6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:58:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id l7so3625287wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 07:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nL1rheNUN9lEuzzFdb2XL3FRoWR7EojL9bAG+X/nUzQ=;
        b=VmT5fzoAyecLK4EH6hOG9xRKy7oVzN+kb9xbXeMDufKYxOLufv6VieVcQ0keJSzU+a
         gXjOM4j0gdbw1tkbagN7pYhF5iz6tLJYTk+29fOiUhV4FyFRvNkROCP5JkeRwTKxebDD
         6+6gR0NkMT6xRpa0NWw0QUwmaVvzK3SOJVJJ4gwDdCYiZormPY0Lnfrc5rHAJu+ffKEr
         JdzxxG5HVoS87uM8Z5KHAnQyYQZgf3c8uH7ZTF7nOwbiV/Vyj7RsZt1Jli3sW+Qb7tID
         cDY/WOzgWC/86z755064fZXYlaXHSWRRiNr1DC3T2TN1toGhk8XpiPT1GrAhDgbS+0Uh
         dncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nL1rheNUN9lEuzzFdb2XL3FRoWR7EojL9bAG+X/nUzQ=;
        b=nCp2J2IcXsiHaHHwyN9ChiV4YgOChNB36RUkJbQV0HuunDVfE3sJ+1oQWygyiPn15F
         GY9vinKgxtL1ZrIcfHNpZSwMNY/MOKlNF2b8s3K8VfUL749H4ocXTI+8lNBe1q/Dv/12
         U6yjxmRDyHwNUvp0UR8FHp7ucNu14ifeUgz3+2Exbw70BL3tpEyztGHhQrasAO9u5stm
         VuO4f3Jsv+8qdWIalnv83FWapNu191p8AVvZ1VQITWALAuZ9SJKrQvEbcfr2vwkJ9KST
         OtW06gVSh5/vaPYglW5zeOCcUX9Iuq/NuIRrEP+4eSfmNV0vy1BqmXiLapYKZX7SfcRW
         ylDg==
X-Gm-Message-State: APjAAAWkxf9ZaTxZvxBcXC41CI+av8trJ/Q9V4zrPTzhIZKdR6WJTfsj
        GK/a6ofFGkFg/cYeBBNaXFOMsw==
X-Google-Smtp-Source: APXvYqz23q0Ee6ynwb1+HB2nx2vWKkBUthxwxwYMRVQO2/o/w1xHoSBPCzqRWrRnGenqJWgZ7d4qkA==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr14209726wrx.212.1573487891043;
        Mon, 11 Nov 2019 07:58:11 -0800 (PST)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id 36sm21256930wrj.42.2019.11.11.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:58:10 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:58:09 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtw88: remove duplicated include from ps.c
Message-ID: <20191111155808.GB29052@netronome.com>
References: <20191111033427.122443-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111033427.122443-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 03:34:27AM +0000, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>


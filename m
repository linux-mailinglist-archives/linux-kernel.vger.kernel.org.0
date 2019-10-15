Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D52D7757
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbfJONUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 09:20:50 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35232 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbfJONUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:20:49 -0400
Received: by mail-yw1-f65.google.com with SMTP id r134so7324640ywg.2;
        Tue, 15 Oct 2019 06:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=D3fT6mJQ0MI3tnwGYI9a5cNsV8GCpshvfBo2XlqzibE=;
        b=JSDWOhRTQR7mcD2V+Sv4e2n37vg6VoRXbzilaYZz3Siqcw+f2p8I8FG1NqtLQpXm+6
         P9YGUWyf/gBw8Yze048gCOiEqBw5KI9q6h1GBINFYm5+bn38Nsa32FEJB7yysMd1S0nK
         VJCT0MhOylRBChpMqW1d/9J/fHwVuzwDKHg/zdjHOeiySQE0yc9sdwgYyKMKl3G9wTxb
         Uf3zdyIgL9gUe8uXeybJkZrTD2G0ddJdcoUhPwCGV0pfezLRgixaxztVeKzkkiOxyXe2
         ASqP8dggBcyk6J0eJYVAcXxQyy62v7UsydVFnI+cEwALKPOnPg3kgBH8uOSblKtNpRU9
         HPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=D3fT6mJQ0MI3tnwGYI9a5cNsV8GCpshvfBo2XlqzibE=;
        b=d989PQjvwx+3h6mMZ0PtYrG2jHZtno/XDtajLSy4giJee6WqNd4RZi/CZ4teX/sGNG
         2B4HfLOAChOboSudlLnPzkQl30MrqKtbuH1alaGXq1eiAzoyLgw8gqyP3aXxQ+kurnEZ
         KYl0ssvNlLiosADlB1CNbRL61ZFbW2+hFSukRPwnPr5GgJw4tjkb3OM20RHZTbA4acsv
         CZqRLEMyvzFAGrfjs4cVkVzgVQ7qXCbg+pCqO02ciEj9FR8RGHxgm+nYnUqkQHQQl7M0
         vF+5IzCXxG9PAHa0zs3Z1RBdQBzVm00KSQ+xTIdSvIloRDkAUSVbk1++28hA9wRCO2Om
         k9cw==
X-Gm-Message-State: APjAAAWDZSlFWuA5C9CLAMJjMZ9WKecT/SYD5q4jjcrZXxSqtgem820j
        sYqoollwGaEVGTwpkFAwFA==
X-Google-Smtp-Source: APXvYqzPaJpFM2drv34anPBYkT5+u0Wp61PBbm/yyybELyaJC0imWzJwOd60Ii1krEpXotxdd/+eNg==
X-Received: by 2002:a81:6c4c:: with SMTP id h73mr15215118ywc.262.1571145647145;
        Tue, 15 Oct 2019 06:20:47 -0700 (PDT)
Received: from 960 ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id l2sm5163256ywd.16.2019.10.15.06.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 06:20:46 -0700 (PDT)
Message-ID: <4eaef0a107796895fc59989d1481676f794fcac5.camel@gmail.com>
Subject: Re: [PATCH] platform/x86: huawei-wmi: make validation stricter in
 huawei_wmi_battery_set()
From:   ayman.bagabas@gmail.com
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Takashi Iwai <tiwai@suse.de>, Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Tue, 15 Oct 2019 09:20:35 -0400
In-Reply-To: <20191015124623.GF21344@kadam>
References: <20191015083837.GA29104@mwanda>
         <CAB3uXr63uUwxBjkeeoftZ6HYm_hmN+E5EUhu15_Mta2qruOugA@mail.gmail.com>
         <20191015124623.GF21344@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-15 at 15:46 +0300, Dan Carpenter wrote:
> On Tue, Oct 15, 2019 at 08:21:59AM -0400, Ayman Bagabas wrote:
> > Hi Dan
> > 
> > On Tue, Oct 15, 2019, 4:39 AM Dan Carpenter <
> > dan.carpenter@oracle.com>
> > wrote:
> > 
> > > I don't think it makes sense for "end" to be negative or for even
> > > for it
> > > to be less than "start".  That also means that "start" can't be
> > > more
> > > than 100 which is good.
> > > 
> > 
> > While this makes sense, you run into issues where you cannot set
> > "start"
> > before "end" and vice versa.
> > 
> > Take this scenario, you have start=70 and end=90, now you want to
> > set these
> > to start=40 and end=60, you would have to set "start" first before
> > you can
> > change the value of "end" otherwise you will run into EINVAL. Now
> > imagine
> > you wanna go the opposite direction, you would have to set "end"
> > before you
> > can change "start".
> > I think having a little wiggle room is fine for such scenarios.
> > 
> 
> I haven't tested this code...  What you're describing sounds really
> very weird to me, but I will accept that you know more about your
> use cases than I do.
> 
> My other concern is that right now you can set start > 100 or end <
> 0.

We should check for these cases.

> 
> regards,
> dan carpenter
> 


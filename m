Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6031496B4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jan 2020 17:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgAYQqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jan 2020 11:46:45 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54664 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAYQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:46:44 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so744514pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 08:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Da0HM3we7N/C1GUMxu+zimrEHhE4JWPgKR0nOJHOax0=;
        b=DOoL2RfM7S03QgOEhu9APCrjgDReQAzGLqgnqfVD/kg3Wnb/WyeqAXAHjIWfft58gv
         Fn7DMFWB+E7KZI66PXQVf47Ugp6ccVqVDXTgHqyBnuv3rpzf0bdkHZwkWL+NFx6RwxWL
         sCMYTwSAjxbhs1HtqMjYSzgHRiVdDeVE13dEpjCOGxFdoI5fspABUYMLFbXspnBfCKSJ
         NKUp0+FVBRnCSdSM1WbYPc4SQ4WXWjDwH0vsFqXDDXDzQ9OZRxC4LQpCAnLf2Imtbhzk
         Pu1N/QT+4TxPqbmKcWzDeS6BBT+WXB2vLEPpFo5gcjwhYxwhzGfJmXeSfklOEECTL8zI
         K7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Da0HM3we7N/C1GUMxu+zimrEHhE4JWPgKR0nOJHOax0=;
        b=A+fWkfpdjZYw/J3ODe3EXP3t141Krpkfb5vCkkqWwFqC0Csj2STyyoSWLMQrauA5+9
         UV05HwImW11F6UNbnn78KK/3jiGjazvDFz7yY+zqBRJrPKavluHPhED/ACLBw1ChhOXl
         aVlmHS+qq9VMXcO5fbpybAI9UKopZH3a6qX7n0+vKhTJd/Z/Mr1glwFyfHeEX3dp2HAa
         mEL9m4Ay7fAvlvV+uSqcRMol8J0lN6Z8jtzoIJqVIJjtuqSBbWYa4eggjBQmePF46tqi
         CYjtZE1IwpWyBLod7fvtoRiFn14loBLWgvI+zFi4H/ILqpTjZtIrfROkLCyij8NKy6Ud
         wqdg==
X-Gm-Message-State: APjAAAUBEVhjUKBXt9X3P5TwI0P8ghnUn5mQfPh3uMN8WzMQIDPn0g6P
        qfM6XZDMeBlaqeO9CdcZ8S3ySi/LBUY=
X-Google-Smtp-Source: APXvYqzUVDfKigGPxPBhqtthKCCZlJs5VZVdHR7gptb0w7GufSkBbH6yqjC3m4DmbZzvF/98/18JXQ==
X-Received: by 2002:a17:902:7d86:: with SMTP id a6mr9752568plm.212.1579970804021;
        Sat, 25 Jan 2020 08:46:44 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r3sm10273769pfg.145.2020.01.25.08.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 08:46:43 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: fix refcounting with OOM
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <fa69cae513308ef3f681e13888a4f551c67ef3a2.1579942715.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <78a57f0e-2412-472a-86c2-5e634a74147f@kernel.dk>
Date:   Sat, 25 Jan 2020 09:46:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fa69cae513308ef3f681e13888a4f551c67ef3a2.1579942715.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/20 1:59 AM, Pavel Begunkov wrote:
> In case of out of memory the second argument of percpu_ref_put_many() in
> io_submit_sqes() may evaluate into "nr - (-EAGAIN)", that is clearly
> wrong.

Can you reorder this one before your series, I haven't had time
to take a look at that yet and I don't think this bug fix should
depend on it.

-- 
Jens Axboe


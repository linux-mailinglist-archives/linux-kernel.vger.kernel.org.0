Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5041F518B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbfFXQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 12:30:38 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:41491 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbfFXQai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:30:38 -0400
Received: by mail-io1-f49.google.com with SMTP id w25so2930190ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wulrto/HXlEP0Cxmn+aSmPqpiH4PSf21/9EuSwKYHd4=;
        b=Mn0cXMbFYMBl0SszZa7WI2WTD5T6951RjYiCrZy61CKf7Cm2DTD9UiLUXwJ0nx0zBY
         1ujuIMMLx77NflyHWBE1yHJcYVq4eHb2AFI56KEKa6Ixd5wfgzHDtkT0WQXMURcOSVAl
         O7Vkq2+51rP5ijLHFX1ZeCKQOT/dDYZntnHe5jyJwkHd7wAslrFu8N5j0IFVI/bIEuwq
         GEjmX3B6uGzH6yZ+b7nKqHGaETy/LXWhmuYf6hpvua3ECqdLlCvvyEH0+IU7TOktpF4M
         zyORQJmP8JKT7T81fNiN8Gbe0OZtEXP/NYrDuoZf7q8Lzo97joLIHKPPtTkz0yI5kWnm
         20kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wulrto/HXlEP0Cxmn+aSmPqpiH4PSf21/9EuSwKYHd4=;
        b=NxSbSUJ8lc7sjekT54KmReS+PyRT3rE4HvNHigPFEhRRnWxD2ySBlc2VEXwCh9y7ex
         Nm82CxBQsHntI3xyhzs2A8TXof/QUDpQGxEGAgCxV3yB4zBLd4aEE3aJymwNB5DtyCfs
         RmU+rgFsLyOOPrvOMGxMKJI0yWb8F90huNuoycqQSYb0YzKaFDc0yVOpDwZUFNm3NE8j
         UHkqOkvDoMAiPn2pWwjAKIlAZ2bgcbA6HNtCng9/aucUN71rKvfxrKjKWKY6YcnLslMS
         h04Fx5tE1xnkk69uOf6as/vmSdyxi/akXKQbZXJbruvqGAyWENAa1oxAsi7y0IpLoG5P
         vGiw==
X-Gm-Message-State: APjAAAU6UMhkgs/w6z5zzfvANRH4wcRFJJbPaPWj01lN1iB7+bcJq3mb
        Dj6vxSNQol1CtHlGRP3uagEugA==
X-Google-Smtp-Source: APXvYqxdhhVgzPshhJyQgs10Hk+zfOquGsuDDw6awgazoiRekD4XFtjDBCvTdDE3FewywU+/yE2bnw==
X-Received: by 2002:a02:5185:: with SMTP id s127mr26639219jaa.44.1561393837131;
        Mon, 24 Jun 2019 09:30:37 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id p25sm13692350iol.48.2019.06.24.09.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 09:30:36 -0700 (PDT)
Subject: WWAN Controller Framework (was IPA [PATCH v2 00/17])
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        subashab@codeaurora.org, abhishek.esse@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20190531035348.7194-1-elder@linaro.org>
Message-ID: <23ff4cce-1fee-98ab-3608-1fd09c2d97f1@linaro.org>
Date:   Mon, 24 Jun 2019 11:30:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190531035348.7194-1-elder@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK I want to try to organize a little more concisely some of the
discussion on this, because there is a very large amount of volume
to date and I think we need to try to narrow the focus back down
again.

I'm going to use a few terms here.  Some of these I really don't
like, but I want to be unambiguous *and* (at least for now) I want
to avoid the very overloaded term "device".

I have lots more to say, but let's start with a top-level picture,
to make sure we're all on the same page.

         WWAN Communication
         Channel (Physical)
                 |     ------------------------
------------     v     |           :+ Control |  \
|          |-----------|           :+ Data    |  |
|    AP    |           | WWAN unit :+ Voice   |   > Functions
|          |===========|           :+ GPS     |  |
------------     ^     |           :+ ...     |  /
                 |     -------------------------
          Multiplexed WWAN
           Communication
         Channel (Physical)

- The *AP* is the main CPU complex that's running Linux on one or
  more CPU cores.
- A *WWAN unit* is an entity that shares one or more physical
  *WWAN communication channels* with the AP.
- A *WWAN communication channel* is a bidirectional means of
  carrying data between the AP and WWAN unit.
- A WWAN communication channel carries data using a *WWAN protocol*.
- A WWAN unit implements one or more *WWAN functions*, such as
  5G data, LTE voice, GPS, and so on.
- A WWAN unit shall implement a *WWAN control function*, used to
  manage the use of other WWAN functions, as well as the WWAN unit
  itself.
- The AP communicates with a WWAN function using a WWAN protocol.
- A WWAN physical channel can be *multiplexed*, in which case it
  carries the data for one or more *WWAN logical channels*.
- A multiplexed WWAN communication channel uses a *WWAN wultiplexing
  protocol*, which is used to separate independent data streams
  carrying other WWAN protocols.
- A WWAN logical channel carries a bidirectional stream of WWAN
  protocol data between an entity on the AP and a WWAN function.

Does that adequately represent a very high-level picture of what
we're trying to manage?

And if I understand it right, the purpose of the generic framework
being discussed is to define a common mechanism for managing (i.e.,
discovering, creating, destroying, querying, configuring, enabling,
disabling, etc.) WWAN units and the functions they implement, along
with the communication and logical channels used to communicate with
them.

Comments?

					-Alex

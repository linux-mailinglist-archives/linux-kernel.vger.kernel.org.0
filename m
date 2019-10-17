Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086EEDB185
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393305AbfJQPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 11:50:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41945 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbfJQPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:50:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id t10so1315350plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=b48asfDAC1xOvEXigDKMakB9AKqpopPhTm0c4Dno6I4=;
        b=Q7IFc7xZihyEUYEqzdNDgyvTR+JI6j7aHEpGPTDNRLWFlTGtfJXqE8f/IF5LuZfSoB
         NhMzEJiu10zAYXuV2qqebPeZYmcXUWFfJjp5JZfvw0xtruK9pfFNAgwLjaz9XPE15Rf4
         +eKD6ZUWoxkShEtqkB3h2ossktGrIafeZiDCY5PHSA0JHbswdZku6KKCLRV6GohcJQUD
         jUSQR0wVwpXS6PUW9keg2SOVAUg11JAnXyN1HctnVfIAN52XRRZoFY2N+mznZ8BTq7Do
         xw08I2su8MdKZBdsPt1Gjj4wcOZKc/zcOc7Am1lPMNYunCX72Q1tQVOiKaUZPnRVeB7Y
         C67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=b48asfDAC1xOvEXigDKMakB9AKqpopPhTm0c4Dno6I4=;
        b=nDeGIobfNog5kbYdLFx9fdBFXZqXaCghuSa1OIPZw5d51mjE6L0Q7pWDT8Rlm3VZeB
         TMo9NrFrXZZMx4heYmEWeXrZNPMe+ygU5PwFoem8R2gA06mqV7uKsFYdZHqK0nUE3by6
         H1Rmdo9kmq01p4iZ+5Tz1R/h2F8iOzWJkYY65FLVj7WLg/tPUJt6oFdYr850Rw47Lodu
         i/9uju+LtvVfjYwhjobvdvTXy+HtwjLqF/5JOwUC8OU1cb3BTfcv1xvY6wC+c8I/OqUe
         xHxIPCHnO3oEUMZGBY15Eb09zHQhfVXYgHECq6dUQytI3SzjNOaZNex7ZCOvBWnQUN6f
         4plw==
X-Gm-Message-State: APjAAAVWOhlb7jZzE2hJuWRSB4TAU7261BeGbDCVLocCfBk3A4W+yZQQ
        a1gtvN1u3lK+Twk06391wmR0nw==
X-Google-Smtp-Source: APXvYqw+ZkikFWm1K6Ej45vWuAlQyN+QOL993PvKnUyJp89FV9RW4sQzKjWGpiIpHo1wns2qTFvzxw==
X-Received: by 2002:a17:902:728f:: with SMTP id d15mr4802632pll.211.1571327452664;
        Thu, 17 Oct 2019 08:50:52 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:d8f2:392e:5b44:157d])
        by smtp.gmail.com with ESMTPSA id z29sm2942555pff.23.2019.10.17.08.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 08:50:52 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH 0/2] arm64: dts: meson: Tronsmart Vega ir keymap updates
In-Reply-To: <1571245657-4471-1-git-send-email-christianshewitt@gmail.com>
References: <1571245657-4471-1-git-send-email-christianshewitt@gmail.com>
Date:   Thu, 17 Oct 2019 08:50:51 -0700
Message-ID: <7hwod3bcbo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> The Tronsmart Vega S95 (S905) and S96 (S912) Android STBs use the
> same IR remote. The rc-vega-s9x keymap has been accepted for Linux
> v5.5 [0] so add the keymap to the respective dts.

Queued for v5.5,

Thanks,

Kevin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2556F141691
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 09:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgARIbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 03:31:44 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44351 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgARIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 03:31:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so25160500qkb.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 00:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fVq2s7ctbNjg2xkWQmjAqx4vqvzLtiNFxE9ruaHMsF4=;
        b=jUJ0asCiNC/a+87gY04yYiADnrd4owMOzDysVtfJLiW4TAsIsbVG89gpv9zunLEUrN
         UsfzZN4bRxI47WmhTdpnnyAWAftmM89X4fIxsXzI1fi7DC6qAilsrTDhGlOOkoQ+REWH
         j3W4Y6+jvkGVvlbR3K4aQ/lygxK8W82BnJdc9GQ6YfdlxQofHuL7vvOG0o8zVnnMs5B+
         w32jWSVbF+a4c0h5F1keFMWHD5XCDQypZDkEEHJJV3LrEV/qINs6pxQ9wER9lslJOZPH
         S4qhBjornshGKL4ZOapN1Op4w4XIE6O6r4++9T+xYGd3aPBDIZetdu8h13CPODZuRvOm
         ra1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fVq2s7ctbNjg2xkWQmjAqx4vqvzLtiNFxE9ruaHMsF4=;
        b=qWHXSdnybM9EBbDh5qRXTXnXrqKmu59cVmiXARWc0SqryB5ZbN/SIgipDZQikJiUtX
         2zcpy+5l273v0We+Pxa0fnVJ15ZuDMkZ3pPGLUAJtdYdnFSjDXT3t+OW+HzqEYXpEk6j
         /nfXLCNwCNwulCsEEg+gTpibqBFmsw8jUDHZwZz50ukWlMpxctMa0Cgo2AiNSfLlsCXb
         022YlXf1M2LjgZd5SeUqYEXntE+nwZiBMdwB5SQDMo2lM0npyCswghQSC7QdgC6dggup
         cv2LASPS4zxdm1rxnxGvg3A21QFpNNp1lUQOgk4WDb2t1UVoezTBPKfK9GnU3Zr7yXH/
         minA==
X-Gm-Message-State: APjAAAXK+7d85/ZjMJtdslq+zYjpV/PnB7peEkpqjCSrWezf2yKn/o8q
        drUEAXZ//gTkMOUki8kN8YAUUpEsLI+icyAAp54s2A==
X-Google-Smtp-Source: APXvYqxEYJi51f+D8Ik90ZYvdVdBWn/b/pxmes6MyloJ3GFDDzapMTvJjDatqA0Urnyn2AKwpo7BKkrLe0SgbBhaJt8=
X-Received: by 2002:a37:bcc7:: with SMTP id m190mr37899221qkf.103.1579336302691;
 Sat, 18 Jan 2020 00:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20191128135057.20020-1-benjamin.gaignard@st.com>
 <878snsvxzu.fsf@intel.com> <CA+M3ks5WvYoDLSrbvaGBbJg9+nnkX=xyCiD389QD8tSCdNqB+g@mail.gmail.com>
 <CA+M3ks4Y4LemFh=dQds91Z-LGJPK3vHKv=GeUNYHjNhdwz_m2g@mail.gmail.com>
 <CA+M3ks4yEBejzMoXPw_OK_LNP7ag5SNXZjvHqNeuZ8+9r2X-qw@mail.gmail.com> <0aa418d049c6d973c2066081da99fc49980159d5.camel@redhat.com>
In-Reply-To: <0aa418d049c6d973c2066081da99fc49980159d5.camel@redhat.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Sat, 18 Jan 2020 09:31:30 +0100
Message-ID: <CA+M3ks5C5W2AFjpxpuz=wLwMR90BEuWe=d92YxyHspmQATwU6g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix W=1 warnings
To:     Lyude Paul <lyude@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 18 janv. 2020 =C3=A0 01:55, Lyude Paul <lyude@redhat.com> a =C3=A9c=
rit :
>
> Hey, does this still need review?

yes please.
There is a question about what we should do of crc4 variable below.

Thanks,
Benjamin
>
> On Tue, 2020-01-07 at 14:11 +0100, Benjamin Gaignard wrote:
> > Le ven. 20 d=C3=A9c. 2019 =C3=A0 15:03, Benjamin Gaignard
> > <benjamin.gaignard@linaro.org> a =C3=A9crit :
> > > Le lun. 16 d=C3=A9c. 2019 =C3=A0 09:28, Benjamin Gaignard
> > > <benjamin.gaignard@linaro.org> a =C3=A9crit :
> > > > Le mer. 4 d=C3=A9c. 2019 =C3=A0 17:47, Jani Nikula <jani.nikula@lin=
ux.intel.com> a
> > > > =C3=A9crit :
> > > > > On Thu, 28 Nov 2019, Benjamin Gaignard <benjamin.gaignard@st.com>
> > > > > wrote:
> > > > > > Fix the warnings that show up with W=3D1.
> > > > > > They are all about unused but set variables.
> > > > > > If functions returns are not used anymore make them void.
> > > > > >
> > > > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > > > > ---
> > > > > > CC: Jani Nikula <jani.nikula@linux.intel.com>
> > > > > >
> > > > > > changes in version 3:
> > > > > > - remove the hunk that may conflict with c485e2c97dae
> > > > > >   ("drm/dp_mst: Refactor pdt setup/teardown, add more locking")
> > > > > >
> > > > > > changes in version 2:
> > > > > > - fix indentations
> > > > > > - when possible change functions prototype to void
> > > > > >
> > > > > > drivers/gpu/drm/drm_dp_mst_topology.c | 83 +++++++++++++-------=
---
> > > > > > ------------
> > > > > >  1 file changed, 31 insertions(+), 52 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > > index 1437bc46368b..d5cb5688b5dd 100644
> > > > > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > > @@ -674,7 +674,6 @@ static bool drm_dp_sideband_msg_build(struc=
t
> > > > > > drm_dp_sideband_msg_rx *msg,
> > > > > >                                     u8 *replybuf, u8 replybufle=
n,
> > > > > > bool hdr)
> > > > > >  {
> > > > > >       int ret;
> > > > > > -     u8 crc4;
> > > > > >
> > > > > >       if (hdr) {
> > > > > >               u8 hdrlen;
> > > > > > @@ -716,8 +715,6 @@ static bool drm_dp_sideband_msg_build(struc=
t
> > > > > > drm_dp_sideband_msg_rx *msg,
> > > > > >       }
> > > > > >
> > > > > >       if (msg->curchunk_idx >=3D msg->curchunk_len) {
> > > > > > -             /* do CRC */
> > > > > > -             crc4 =3D drm_dp_msg_data_crc4(msg->chunk, msg-
> > > > > > >curchunk_len - 1);
> > > > >
> > > > > Again, someone needs to check if crc4 should be *used* instead of
> > > > > thrown
> > > > > away. Blindly throwing stuff out is not the way to go.
> > > >
> > > > Hi Dave,
> > > >
> > >
> > > + Lyude who has been hacking in this code recently
> >
> > gentle ping for the reviewers,
> >
> > Thanks,
> > Benjamin
> > > > Your are the original writer of this code, could you tell us if we =
can
> > > > drop crc4
> > > > ao if there is something else that I have misunderstood ?
> > > >
> > > > Thanks,
> > > > Benjamin
> > > >
> > > > > BR,
> > > > > Jani.
> > > > >
> > > > > >               /* copy chunk into bigger msg */
> > > > > >               memcpy(&msg->msg[msg->curlen], msg->chunk, msg-
> > > > > > >curchunk_len - 1);
> > > > > >               msg->curlen +=3D msg->curchunk_len - 1;
> > > > > > @@ -1014,7 +1011,7 @@ static bool drm_dp_sideband_parse_req(str=
uct
> > > > > > drm_dp_sideband_msg_rx *raw,
> > > > > >       }
> > > > > >  }
> > > > > >
> > > > > > -static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg=
, u8
> > > > > > port_num, u32 offset, u8 num_bytes, u8 *bytes)
> > > > > > +static void build_dpcd_write(struct drm_dp_sideband_msg_tx *ms=
g, u8
> > > > > > port_num, u32 offset, u8 num_bytes, u8 *bytes)
> > > > > >  {
> > > > > >       struct drm_dp_sideband_msg_req_body req;
> > > > > >
> > > > > > @@ -1024,17 +1021,14 @@ static int build_dpcd_write(struct
> > > > > > drm_dp_sideband_msg_tx *msg, u8 port_num, u32
> > > > > >       req.u.dpcd_write.num_bytes =3D num_bytes;
> > > > > >       req.u.dpcd_write.bytes =3D bytes;
> > > > > >       drm_dp_encode_sideband_req(&req, msg);
> > > > > > -
> > > > > > -     return 0;
> > > > > >  }
> > > > > >
> > > > > > -static int build_link_address(struct drm_dp_sideband_msg_tx *m=
sg)
> > > > > > +static void build_link_address(struct drm_dp_sideband_msg_tx *=
msg)
> > > > > >  {
> > > > > >       struct drm_dp_sideband_msg_req_body req;
> > > > > >
> > > > > >       req.req_type =3D DP_LINK_ADDRESS;
> > > > > >       drm_dp_encode_sideband_req(&req, msg);
> > > > > > -     return 0;
> > > > > >  }
> > > > > >
> > > > > >  static int build_enum_path_resources(struct drm_dp_sideband_ms=
g_tx
> > > > > > *msg, int port_num)
> > > > > > @@ -1048,7 +1042,7 @@ static int build_enum_path_resources(stru=
ct
> > > > > > drm_dp_sideband_msg_tx *msg, int por
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > -static int build_allocate_payload(struct drm_dp_sideband_msg_t=
x
> > > > > > *msg, int port_num,
> > > > > > +static void build_allocate_payload(struct drm_dp_sideband_msg_=
tx
> > > > > > *msg, int port_num,
> > > > > >                                 u8 vcpi, uint16_t pbn,
> > > > > >                                 u8 number_sdp_streams,
> > > > > >                                 u8 *sdp_stream_sink)
> > > > > > @@ -1064,10 +1058,9 @@ static int build_allocate_payload(struct
> > > > > > drm_dp_sideband_msg_tx *msg, int port_n
> > > > > >                  number_sdp_streams);
> > > > > >       drm_dp_encode_sideband_req(&req, msg);
> > > > > >       msg->path_msg =3D true;
> > > > > > -     return 0;
> > > > > >  }
> > > > > >
> > > > > > -static int build_power_updown_phy(struct drm_dp_sideband_msg_t=
x
> > > > > > *msg,
> > > > > > +static void build_power_updown_phy(struct drm_dp_sideband_msg_=
tx
> > > > > > *msg,
> > > > > >                                 int port_num, bool power_up)
> > > > > >  {
> > > > > >       struct drm_dp_sideband_msg_req_body req;
> > > > > > @@ -1080,7 +1073,6 @@ static int build_power_updown_phy(struct
> > > > > > drm_dp_sideband_msg_tx *msg,
> > > > > >       req.u.port_num.port_number =3D port_num;
> > > > > >       drm_dp_encode_sideband_req(&req, msg);
> > > > > >       msg->path_msg =3D true;
> > > > > > -     return 0;
> > > > > >  }
> > > > > >
> > > > > >  static int drm_dp_mst_assign_payload_id(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > > @@ -1746,14 +1738,13 @@ static u8 drm_dp_calculate_rad(struct
> > > > > > drm_dp_mst_port *port,
> > > > > >   */
> > > > > >  static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port=
)
> > > > > >  {
> > > > > > -     int ret;
> > > > > >       u8 rad[6], lct;
> > > > > >       bool send_link =3D false;
> > > > > >       switch (port->pdt) {
> > > > > >       case DP_PEER_DEVICE_DP_LEGACY_CONV:
> > > > > >       case DP_PEER_DEVICE_SST_SINK:
> > > > > >               /* add i2c over sideband */
> > > > > > -             ret =3D drm_dp_mst_register_i2c_bus(&port->aux);
> > > > > > +             drm_dp_mst_register_i2c_bus(&port->aux);
> > > > > >               break;
> > > > > >       case DP_PEER_DEVICE_MST_BRANCHING:
> > > > > >               lct =3D drm_dp_calculate_rad(port, rad);
> > > > > > @@ -1823,25 +1814,20 @@ ssize_t drm_dp_mst_dpcd_write(struct
> > > > > > drm_dp_aux *aux,
> > > > > >
> > > > > >  static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *m=
stb,
> > > > > > u8 *guid)
> > > > > >  {
> > > > > > -     int ret;
> > > > > > -
> > > > > >       memcpy(mstb->guid, guid, 16);
> > > > > >
> > > > > >       if (!drm_dp_validate_guid(mstb->mgr, mstb->guid)) {
> > > > > >               if (mstb->port_parent) {
> > > > > > -                     ret =3D drm_dp_send_dpcd_write(
> > > > > > -                                     mstb->mgr,
> > > > > > -                                     mstb->port_parent,
> > > > > > -                                     DP_GUID,
> > > > > > -                                     16,
> > > > > > -                                     mstb->guid);
> > > > > > +                     drm_dp_send_dpcd_write(mstb->mgr,
> > > > > > +                                            mstb->port_parent,
> > > > > > +                                            DP_GUID,
> > > > > > +                                            16,
> > > > > > +                                            mstb->guid);
> > > > > >               } else {
> > > > > > -
> > > > > > -                     ret =3D drm_dp_dpcd_write(
> > > > > > -                                     mstb->mgr->aux,
> > > > > > -                                     DP_GUID,
> > > > > > -                                     mstb->guid,
> > > > > > -                                     16);
> > > > > > +                     drm_dp_dpcd_write(mstb->mgr->aux,
> > > > > > +                                       DP_GUID,
> > > > > > +                                       mstb->guid,
> > > > > > +                                       16);
> > > > > >               }
> > > > > >       }
> > > > > >  }
> > > > > > @@ -2197,7 +2183,7 @@ static bool drm_dp_validate_guid(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >       return false;
> > > > > >  }
> > > > > >
> > > > > > -static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg,=
 u8
> > > > > > port_num, u32 offset, u8 num_bytes)
> > > > > > +static void build_dpcd_read(struct drm_dp_sideband_msg_tx *msg=
, u8
> > > > > > port_num, u32 offset, u8 num_bytes)
> > > > > >  {
> > > > > >       struct drm_dp_sideband_msg_req_body req;
> > > > > >
> > > > > > @@ -2206,8 +2192,6 @@ static int build_dpcd_read(struct
> > > > > > drm_dp_sideband_msg_tx *msg, u8 port_num, u32
> > > > > >       req.u.dpcd_read.dpcd_address =3D offset;
> > > > > >       req.u.dpcd_read.num_bytes =3D num_bytes;
> > > > > >       drm_dp_encode_sideband_req(&req, msg);
> > > > > > -
> > > > > > -     return 0;
> > > > > >  }
> > > > > >
> > > > > >  static int drm_dp_send_sideband_msg(struct drm_dp_mst_topology=
_mgr
> > > > > > *mgr,
> > > > > > @@ -2429,14 +2413,14 @@ static void drm_dp_send_link_address(st=
ruct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >  {
> > > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > > >       struct drm_dp_link_address_ack_reply *reply;
> > > > > > -     int i, len, ret;
> > > > > > +     int i, ret;
> > > > > >
> > > > > >       txmsg =3D kzalloc(sizeof(*txmsg), GFP_KERNEL);
> > > > > >       if (!txmsg)
> > > > > >               return;
> > > > > >
> > > > > >       txmsg->dst =3D mstb;
> > > > > > -     len =3D build_link_address(txmsg);
> > > > > > +     build_link_address(txmsg);
> > > > > >
> > > > > >       mstb->link_address_sent =3D true;
> > > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > > @@ -2478,7 +2462,6 @@ drm_dp_send_enum_path_resources(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >  {
> > > > > >       struct drm_dp_enum_path_resources_ack_reply *path_res;
> > > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > > > -     int len;
> > > > > >       int ret;
> > > > > >
> > > > > >       txmsg =3D kzalloc(sizeof(*txmsg), GFP_KERNEL);
> > > > > > @@ -2486,7 +2469,7 @@ drm_dp_send_enum_path_resources(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >               return -ENOMEM;
> > > > > >
> > > > > >       txmsg->dst =3D mstb;
> > > > > > -     len =3D build_enum_path_resources(txmsg, port->port_num);
> > > > > > +     build_enum_path_resources(txmsg, port->port_num);
> > > > > >
> > > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > >
> > > > > > @@ -2569,7 +2552,7 @@ static int drm_dp_payload_send_msg(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >  {
> > > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > > >       struct drm_dp_mst_branch *mstb;
> > > > > > -     int len, ret, port_num;
> > > > > > +     int ret, port_num;
> > > > > >       u8 sinks[DRM_DP_MAX_SDP_STREAMS];
> > > > > >       int i;
> > > > > >
> > > > > > @@ -2594,9 +2577,9 @@ static int drm_dp_payload_send_msg(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >               sinks[i] =3D i;
> > > > > >
> > > > > >       txmsg->dst =3D mstb;
> > > > > > -     len =3D build_allocate_payload(txmsg, port_num,
> > > > > > -                                  id,
> > > > > > -                                  pbn, port->num_sdp_streams,
> > > > > > sinks);
> > > > > > +     build_allocate_payload(txmsg, port_num,
> > > > > > +                            id,
> > > > > > +                            pbn, port->num_sdp_streams, sinks)=
;
> > > > > >
> > > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > >
> > > > > > @@ -2625,7 +2608,7 @@ int drm_dp_send_power_updown_phy(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >                                struct drm_dp_mst_port *port, bo=
ol
> > > > > > power_up)
> > > > > >  {
> > > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > > > -     int len, ret;
> > > > > > +     int ret;
> > > > > >
> > > > > >       port =3D drm_dp_mst_topology_get_port_validated(mgr, port=
);
> > > > > >       if (!port)
> > > > > > @@ -2638,7 +2621,7 @@ int drm_dp_send_power_updown_phy(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >       }
> > > > > >
> > > > > >       txmsg->dst =3D port->parent;
> > > > > > -     len =3D build_power_updown_phy(txmsg, port->port_num, pow=
er_up);
> > > > > > +     build_power_updown_phy(txmsg, port->port_num, power_up);
> > > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > >
> > > > > >       ret =3D drm_dp_mst_wait_tx_reply(port->parent, txmsg);
> > > > > > @@ -2858,7 +2841,6 @@ static int drm_dp_send_dpcd_read(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >                                struct drm_dp_mst_port *port,
> > > > > >                                int offset, int size, u8 *bytes)
> > > > > >  {
> > > > > > -     int len;
> > > > > >       int ret =3D 0;
> > > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > > >       struct drm_dp_mst_branch *mstb;
> > > > > > @@ -2873,7 +2855,7 @@ static int drm_dp_send_dpcd_read(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >               goto fail_put;
> > > > > >       }
> > > > > >
> > > > > > -     len =3D build_dpcd_read(txmsg, port->port_num, offset, si=
ze);
> > > > > > +     build_dpcd_read(txmsg, port->port_num, offset, size);
> > > > > >       txmsg->dst =3D port->parent;
> > > > > >
> > > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > > @@ -2911,7 +2893,6 @@ static int drm_dp_send_dpcd_write(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >                                 struct drm_dp_mst_port *port,
> > > > > >                                 int offset, int size, u8 *bytes=
)
> > > > > >  {
> > > > > > -     int len;
> > > > > >       int ret;
> > > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > > >       struct drm_dp_mst_branch *mstb;
> > > > > > @@ -2926,7 +2907,7 @@ static int drm_dp_send_dpcd_write(struct
> > > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > >               goto fail_put;
> > > > > >       }
> > > > > >
> > > > > > -     len =3D build_dpcd_write(txmsg, port->port_num, offset, s=
ize,
> > > > > > bytes);
> > > > > > +     build_dpcd_write(txmsg, port->port_num, offset, size, byt=
es);
> > > > > >       txmsg->dst =3D mstb;
> > > > > >
> > > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > > @@ -3149,7 +3130,7 @@ static bool drm_dp_get_one_sb_msg(struct
> > > > > > drm_dp_mst_topology_mgr *mgr, bool up)
> > > > > >  {
> > > > > >       int len;
> > > > > >       u8 replyblock[32];
> > > > > > -     int replylen, origlen, curreply;
> > > > > > +     int replylen, curreply;
> > > > > >       int ret;
> > > > > >       struct drm_dp_sideband_msg_rx *msg;
> > > > > >       int basereg =3D up ? DP_SIDEBAND_MSG_UP_REQ_BASE :
> > > > > > DP_SIDEBAND_MSG_DOWN_REP_BASE;
> > > > > > @@ -3169,7 +3150,6 @@ static bool drm_dp_get_one_sb_msg(struct
> > > > > > drm_dp_mst_topology_mgr *mgr, bool up)
> > > > > >       }
> > > > > >       replylen =3D msg->curchunk_len + msg->curchunk_hdrlen;
> > > > > >
> > > > > > -     origlen =3D replylen;
> > > > > >       replylen -=3D len;
> > > > > >       curreply =3D len;
> > > > > >       while (replylen > 0) {
> > > > > > @@ -3961,17 +3941,16 @@ void drm_dp_mst_dump_topology(struct
> > > > > > seq_file *m,
> > > > > >       mutex_lock(&mgr->lock);
> > > > > >       if (mgr->mst_primary) {
> > > > > >               u8 buf[DP_PAYLOAD_TABLE_SIZE];
> > > > > > -             int ret;
> > > > > >
> > > > > > -             ret =3D drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, b=
uf,
> > > > > > DP_RECEIVER_CAP_SIZE);
> > > > > > +             drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf,
> > > > > > DP_RECEIVER_CAP_SIZE);
> > > > > >               seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZ=
E,
> > > > > > buf);
> > > > > > -             ret =3D drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, b=
uf, 2);
> > > > > > +             drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
> > > > > >               seq_printf(m, "faux/mst: %*ph\n", 2, buf);
> > > > > > -             ret =3D drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, =
buf,
> > > > > > 1);
> > > > > > +             drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
> > > > > >               seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
> > > > > >
> > > > > >               /* dump the standard OUI branch header */
> > > > > > -             ret =3D drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI,=
 buf,
> > > > > > DP_BRANCH_OUI_HEADER_SIZE);
> > > > > > +             drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf,
> > > > > > DP_BRANCH_OUI_HEADER_SIZE);
> > > > > >               seq_printf(m, "branch oui: %*phN devid: ", 3, buf=
);
> > > > > >               for (i =3D 0x3; i < 0x8 && buf[i]; i++)
> > > > > >                       seq_printf(m, "%c", buf[i]);
> > > > >
> > > > > --
> > > > > Jani Nikula, Intel Open Source Graphics Center
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> --
> Cheers,
>         Lyude Paul
>

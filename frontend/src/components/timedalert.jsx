/* eslint-disable react/prop-types */
import { useState, useEffect } from 'react'
import { Alert } from 'react-bootstrap'

export default function TimedAlert({ msg }) {
    const [show, setShow] = useState(false)

    useEffect(() => {
        if (msg.variant !== "boot") {
            setShow(true)
            setTimeout(() => setShow(false), 3000)
        }
    }, [msg.variant])

    return (
        <Alert show={show} variant={msg.variant}>{msg.text}</Alert>
    )
}